{
  neovim.mods = { mkRaw, ... }: {
    extraConfigLua = # lua
      ''
        _G.open_in_kitty = function(file, line, col)
          -- Expand to absolute path to ensure kitty finds it
          local path = vim.fn.fnamemodify(file, ":p")
          local cmd = "kitty -1 nvim"
          if line and col then
            cmd = cmd .. string.format(" '+call cursor(%d, %d)'", line, col)
          elseif line then
            cmd = cmd .. string.format(" '+%d'", line)
          end
          -- Escape the path properly
          cmd = cmd .. string.format(" %s", vim.fn.shellescape(path))

          -- Spawn the kitty window asynchronously
          os.execute(cmd .. " >/dev/null 2>&1 &")
        end

        -- Provide a command to manually open a file in a new kitty window
        vim.api.nvim_create_user_command("Kedit", function(opts)
          _G.open_in_kitty(opts.args)
        end, { nargs = 1, complete = "file" })
      '';
    plugins.snacks.settings.picker.actions = {
      hypr_focus_or_edit = mkRaw ''
        function(picker, item, action)
          local confirm = require("snacks.picker.actions").confirm
          if not item or not item.file then
            return confirm(picker, item, action)
          end

          local path = vim.fn.fnamemodify(item.file, ":p:~")
          local kitty_window_id = nil

          local uid = vim.fn.system("id -u"):gsub("%s+", "")
          local sockets = vim.fn.glob("/run/user/" .. uid .. "/nvim.*.0", true, true)
          for _, socket in ipairs(sockets) do
            local connect_ok, chan_id = pcall(vim.fn.sockconnect, "pipe", socket, {rpc=true})
            if connect_ok and chan_id > 0 then
              local req_ok, remote_path = pcall(vim.rpcrequest, chan_id, "nvim_eval", "expand('%:p:~')")
              if req_ok and remote_path == path then
                kitty_window_id = vim.rpcrequest(chan_id, "nvim_eval", 'getenv("KITTY_WINDOW_ID")')
                
                -- Jump to line if grep/pos exists
                if item.pos then
                  vim.rpcnotify(chan_id, "nvim_command", string.format("call cursor(%d, %d)", item.pos[1], item.pos[2]))
                  vim.rpcnotify(chan_id, "nvim_command", "normal! zz")
                end
                
                vim.fn.chanclose(chan_id)
                break
              end
              vim.fn.chanclose(chan_id)
            end
          end

          if kitty_window_id and kitty_window_id ~= vim.NIL then
            -- Focus the kitty window containing this neovim process
            local cmd = string.format("kitty @ focus-window -m id:%s", kitty_window_id)
            os.execute(cmd .. " >/dev/null 2>&1")
            picker:close()
            return
          end

          -- If not found, open in a new kitty terminal instead of current buffer!
          if _G.open_in_kitty then
            local line = item.pos and item.pos[1] or nil
            local col = item.pos and item.pos[2] or nil
            _G.open_in_kitty(item.file, line, col)
          else
            -- Fallback if custom-buffer.nix isn't loaded
            confirm(picker, item, action)
          end

          picker:close()
        end
      '';
    };

  };
}
