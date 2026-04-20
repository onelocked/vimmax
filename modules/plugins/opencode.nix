{
  flake.modules.plugins.opencode =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.opencode-nvim ];
      extraConfigLua = ''
        ----------------------------------------------------------------------
        -- opencode.nvim — tmux integration
        --   • spawns `opencode --port` in a detached tmux split
        --   • zooms the pane while opencode is booting so you see the TUI
        --     come up fullscreen
        --   • unzooms back to the split as soon as opencode acknowledges
        --     the submitted prompt
        ----------------------------------------------------------------------

        local OPENCODE_CMD    = "opencode --port"
        local OPENCODE_MARKER = "opencode --port"  -- substring used to grep panes
        local SPLIT_PERCENT   = 40

        -- tmux helper: build argv and return trimmed stdout ----------------
        local function tmux(argv)
          local cmd = { "tmux" }
          for _, a in ipairs(argv) do cmd[#cmd + 1] = a end
          local out = vim.fn.system(cmd) or ""
          return (out:gsub("%s+$", ""))
        end

        local function in_tmux()
          return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
        end

        local function find_opencode_pane()
          if not in_tmux() then return nil end
          local out = tmux({
            "list-panes", "-a",
            "-F", "#{pane_id} #{pane_start_command}",
          })
          for line in out:gmatch("[^\r\n]+") do
            local id, c = line:match("^(%S+)%s+(.*)$")
            if id and c and c:find(OPENCODE_MARKER, 1, true) then
              return id
            end
          end
          return nil
        end

        local function is_zoomed(pane_id)
          if not pane_id then return false end
          return tmux({
            "display-message", "-p", "-t", pane_id, "#{window_zoomed_flag}",
          }) == "1"
        end

        local function zoom(pane_id)
          if pane_id and not is_zoomed(pane_id) then
            tmux({ "resize-pane", "-Z", "-t", pane_id })
          end
        end

        local function unzoom(pane_id)
          if pane_id and is_zoomed(pane_id) then
            tmux({ "resize-pane", "-Z", "-t", pane_id })
          end
        end

        -- Spawn opencode in a detached split and zoom the current nvim pane so it
        -- takes the whole window while booting. Focus stays in nvim.
        -- Idempotent: returns the existing pane if one is already running.
        local function spawn_opencode()
          if not in_tmux() then
            vim.notify("opencode: not inside tmux", vim.log.levels.WARN)
            return nil
          end
          local existing = find_opencode_pane()
          if existing then return existing end

          local current_pane = tmux({ "display-message", "-p", "#{pane_id}" })

          tmux({
            "split-window", "-h", "-d",
            "-l", tostring(SPLIT_PERCENT) .. "%",
            OPENCODE_CMD,
          })

          zoom(current_pane)
          return find_opencode_pane()
        end

        local function kill_opencode()
          local pane = find_opencode_pane()
          local current_pane = tmux({ "display-message", "-p", "#{pane_id}" })
          if pane then
            unzoom(current_pane)
            tmux({ "kill-pane", "-t", pane })
          end
        end

        ----------------------------------------------------------------------
        -- Plugin config
        --
        -- IMPORTANT: opencode.nvim uses `server = { start, stop, toggle }`,
        -- NOT `provider` (the `provider` option was removed upstream). The
        -- plugin calls these hooks to spawn / kill / toggle the opencode
        -- process itself. Because of this, the keymap below MUST NOT also
        -- call spawn_opencode() — `ask()` will trigger `start` automatically,
        -- and a manual call races against the plugin's own discovery and
        -- ends up spawning a second opencode session.
        ----------------------------------------------------------------------
        ---@type opencode.Opts
        vim.g.opencode_opts = {
          server = {
            start  = function() spawn_opencode() end,
            stop   = function() kill_opencode() end,
            toggle = function()
              if find_opencode_pane() then kill_opencode() else spawn_opencode() end
            end,
          },
        }

        vim.o.autoread = true  -- needed by opencode.nvim's reload events

        -- Unzoom whenever opencode receives a message (the prompt was
        -- submitted and reached the server). Covers every ask without
        -- per-keymap bookkeeping.
        vim.api.nvim_create_autocmd("User", {
          pattern  = "OpencodeEvent:message.updated",
          callback = function()
            local current_pane = tmux({ "display-message", "-p", "#{pane_id}" })
            unzoom(current_pane)
          end,
          desc     = "opencode: restore tmux split after submit",
        })

        ----------------------------------------------------------------------
        -- Keymaps
        ----------------------------------------------------------------------

        -- Just call ask() — the plugin will invoke server.start (our
        -- spawn_opencode) on its own, exactly once. The pane comes up
        -- zoomed so opencode boots fullscreen; on submit the autocmd
        -- above unzooms back to the split.
        vim.keymap.set({ "n", "x" }, "<leader>a", function()
          require("opencode").ask("@this: ", { submit = true })
        end, { desc = "Opencode: ask @this" })

        vim.keymap.set({ "n", "t" }, "<leader>o", function()
          require("opencode").toggle()
        end, { desc = "Opencode: toggle tmux pane" })

        vim.keymap.set({ "n", "x" }, "<leader>oa", function()
          require("opencode").select()
        end, { desc = "Opencode: select prompt / command" })
      '';
    };
}
