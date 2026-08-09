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
                      local ok, _ = pcall(vim.cmd, "colorscheme sorbet")

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
