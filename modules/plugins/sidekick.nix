{
  flake.modules.plugins.sidekick =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.sidekick-nvim ];
      extraConfigLua = ''
        require("sidekick").setup({
          nes = { enabled = false }, -- Disable Next Edit Suggestions
          cli = {
            tool = "gemini",
            picker = "snacks",
            mux = {
              enabled = true,
              backend = "tmux",
            },
          },
        })

        local GEMINI_CMD    = "gemini"
        local GEMINI_TAG    = "@sidekick"
        local SPLIT_PERCENT = 30
        local gemini_pane_id = nil

        -- Execute tmux command and return trimmed output
        local function tmux(argv)
          local cmd = { "tmux" }
          for _, a in ipairs(argv) do cmd[#cmd + 1] = a end
          local out = vim.fn.system(cmd) or ""
          return (out:gsub("%s+$", ""))
        end

        -- Check if current process is running inside tmux
        local function in_tmux()
          return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
        end

        -- Check if a tmux pane ID still exists/is active
        local function pane_alive(pane_id)
          if not pane_id then return false end
          tmux({ "display-message", "-p", "-t", pane_id, "#{pane_id}" })
          return vim.v.shell_error == 0
        end

        -- Search all panes for one tagged with @sidekick user option
        local function find_gemini_pane()
          local out = tmux({ "list-panes", "-a", "-F", "#{pane_id} #{" .. GEMINI_TAG .. "}" })
          for line in out:gmatch("[^\r\n]+") do
            local id, tag = line:match("^(%S+)%s+(.*)$")
            if id and tag == "gemini" then
              return id
            end
          end
          return nil
        end

        -- Resolve existing gemini pane or spawn new one, return pane ID
        local function ensure_gemini_pane()
          -- Try stored ID first
          if gemini_pane_id and pane_alive(gemini_pane_id) then
            return gemini_pane_id
          end
          -- Search window for existing gemini (survives nvim restart)
          local found = find_gemini_pane()
          if found then
            gemini_pane_id = found
            return found
          end
          -- Spawn new + tag with title
          local new_pane = tmux({
            "split-window", "-h", "-d", "-P", "-F", "#{pane_id}",
            "-l", SPLIT_PERCENT .. "%",
            GEMINI_CMD,
          })
          tmux({ "set-option", "-p", "-t", new_pane, GEMINI_TAG, "gemini" })
          gemini_pane_id = new_pane
          return new_pane
        end

        -- Check if gemini pane is in current window's pane list
        local function gemini_visible()
          if not gemini_pane_id then return false end
          local out = tmux({ "list-panes", "-F", "#{pane_id}" })
          for line in out:gmatch("[^\r\n]+") do
            if line == gemini_pane_id then return true end
          end
          return false
        end

        local function toggle_gemini()
          if not in_tmux() then
            vim.notify("gemini: not inside tmux", vim.log.levels.WARN)
            return
          end

          -- Resolve or find existing pane (don't spawn yet)
          if gemini_pane_id and not pane_alive(gemini_pane_id) then
            gemini_pane_id = nil
          end
          if not gemini_pane_id then
            gemini_pane_id = find_gemini_pane()
          end

          if not gemini_pane_id then
            -- No pane exists → spawn visible
            ensure_gemini_pane()
          elseif gemini_visible() then
            -- Visible → hide to background window
            tmux({ "break-pane", "-d", "-s", gemini_pane_id })
          else
            -- Hidden → bring back as right split
            tmux({
              "join-pane", "-h", "-d",
              "-l", SPLIT_PERCENT .. "%",
              "-s", gemini_pane_id,
            })
          end
        end

        -- Sidekick Keymaps
        vim.keymap.set({ "n", "x" }, "<leader>as", toggle_gemini, { desc = "Sidekick: toggle gemini (tmux)" })
        vim.keymap.set({ "n", "x" }, "<leader>ac", "<cmd>Sidekick cli select<cr>", { desc = "Sidekick: select tool" })
        vim.keymap.set({ "n", "x" }, "<leader>ap", "<cmd>Sidekick cli prompt<cr>", { desc = "Sidekick: select prompt" })

        -- Custom AI Ask (leader-a) using Snacks.input
        -- We use manual filename expansion (@filename) instead of {file}/{this}
        -- to prevent sidekick from automatically appending cursor position (:L:C),
        -- which is redundant when we're already passing the specific line range.
        vim.keymap.set({ "n", "x" }, "<leader>aa", function()
          local is_visual = vim.fn.mode():match("^[vV\22]")
          local target = "@" .. vim.fn.expand("%")
          local range = ""
          if is_visual then
            local l1, l2 = vim.fn.line("v"), vim.fn.line(".")
            if l1 > l2 then l1, l2 = l2, l1 end
            range = string.format(" :L%d-L%d", l1, l2)
          end

          Snacks.input({
            prompt = "AI Ask (" .. (is_visual and "selection" or "file") .. "): ",
          }, function(input)
            if input and input ~= "" then
              require("sidekick.cli").send({ msg = input .. "\n" .. target .. range, submit = true })
              if in_tmux() then
                ensure_gemini_pane()
                if not gemini_visible() then
                  tmux({
                    "join-pane", "-h", "-d",
                    "-l", SPLIT_PERCENT .. "%",
                    "-s", gemini_pane_id,
                  })
                end
              end
            end
          end)
        end, { desc = "Sidekick: Ask AI" })
      '';
    };
}
