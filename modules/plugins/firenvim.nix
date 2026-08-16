{
  exo.mods =
    { lib, config, ... }:
    let
      cfg = config.plugins.firenvim;
    in
    {
      plugins = {
        firenvim = {
          # firenvim documentation
          # See: https://github.com/glacambre/firenvim
          enable = lib.mkDefault true;
          # NOTE: Call the installation for first time use
          # :call firenvim#install(0)

          settings = {
            localSettings = {
              ".*" = {
                cmdline = "neovim";
                content = "text";
                priority = 0;
                selector = "textarea, input[type=\"text\"], input[type=\"search\"], div[contenteditable], div[role=\"textbox\"]";
                takeover = "never";
              };
            };
          };
        };
      };

      autoCmd = lib.optionals cfg.enable [
        {
          event = "UIEnter";
          callback = {
            __raw = ''
              function(event)
                  local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
                  if client ~= nil and client.name == "Firenvim" then
                      local function detect_firenvim_ft(bufnr)
                          local name = string.lower(vim.api.nvim_buf_get_name(bufnr))
                          local stripped = name:gsub("%([^)]*%)%.txt$", ""):gsub("%.txt$", "")

                          local segments = {}
                          for seg in stripped:gmatch("[^_]+") do
                              segments[#segments + 1] = seg
                          end

                          for i = #segments, 1, -1 do
                              local candidate = segments[i]:gsub("%-", ".")
                              local tmp = vim.api.nvim_create_buf(false, true)
                              vim.api.nvim_buf_set_name(tmp, candidate)
                              local ok, ft = pcall(vim.filetype.match, { buf = tmp })
                              vim.api.nvim_buf_delete(tmp, { force = true })
                              if ok and ft and ft ~= "" and ft ~= "text" then
                                  return ft
                              end
                          end

                          if name:match("reddit%.com") then return "markdown" end
                          if name:match("discord%.com") then return "markdown" end
                          if name:match("stackoverflow%.com") then return "markdown" end
                          return nil
                      end

                      local function apply_ft(bufnr)
                          local ft = detect_firenvim_ft(bufnr)
                          if ft then
                              vim.api.nvim_set_option_value("filetype", ft, { buf = bufnr })
                          end
                      end

                      vim.defer_fn(function() apply_ft(0) end, 200)

                      vim.api.nvim_create_autocmd("BufEnter", {
                          pattern = "*",
                          callback = function(e)
                              vim.defer_fn(function() apply_ft(e.buf) end, 200)
                          end,
                      })

                      vim.o.guifont = "Maple Mono NF ExtraBold"

                      vim.o.laststatus = 0
                      vim.o.showtabline = 0
                      vim.o.ruler = false
                      vim.o.showcmd = false
                      vim.o.cmdheight = 0

                      vim.o.statusline = ""
                      vim.o.winbar = ""

                      pcall(function()
                          require('lualine').hide({ place = {'statusline', 'tabline', 'winbar'} })
                      end)

                      vim.opt.shortmess:append("I")
                      vim.opt.shortmess:append("F")

                      pcall(function() require("noice").cmd("dismiss") end)
                  end
              end
            '';
          };
        }
      ];
    };
}
