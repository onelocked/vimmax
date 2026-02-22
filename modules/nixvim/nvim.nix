{ self, ... }:
{
  flake.modules.nixvim.core =
    {
      lib,
      ...
    }:
    let
      inherit (self.helpers.onevix) icons;
    in
    {
      luaLoader.enable = false;
      dependencies = {
        gcc.enable = true;
      };

      globals = {
        mapleader = self.helpers.onevix.leader;
        floating_window_options.border = "rounded";
      };

      opts = {

        clipboard = "unnamedplus";
        cursorline = true;
        cursorlineopt = "number";

        pumblend = 0;
        pumheight = 10;

        expandtab = true;
        shiftwidth = 2;
        smartindent = true;
        tabstop = 2;
        softtabstop = 2;

        ignorecase = true;
        smartcase = true;
        mouse = "a";
        cmdheight = 0;

        number = true;
        relativenumber = true;
        numberwidth = 2;
        ruler = false;

        signcolumn = "yes";
        splitbelow = true;
        splitright = true;
        splitkeep = "screen";
        termguicolors = true;

        conceallevel = 2;

        undofile = true;

        wrap = false;

        virtualedit = "block";
        winminwidth = 5;
        fileencoding = "utf-8";
        list = true;
        smoothscroll = true;
        autoread = true;
        fillchars = {
          eob = " ";
        };

        updatetime = 500;
      };

      autoCmd = [
        {
          desc = "Highlight on yank";
          event = [ "TextYankPost" ];
          callback = lib.nixvim.mkRaw ''
            function()
              vim.highlight.on_yank()
            end
          '';
        }
      ];

      extraLuaPackages = lp: with lp; [ luarocks ];
      extraConfigLua = with icons.diagnostics; ''
        vim.opt.whichwrap:append("<>[]hl")
        vim.opt.listchars:append("space:·")

        -- below part set's the Diagnostic icons/colors
        local signs = {
          Hint = "${BoldHint}",
          Info = "${BoldInformation}",
          Warn = "${BoldWarning}",
          Error = "${BoldError}",
        }

        for type, icon in pairs(signs) do
          local hl = "DiagnosticSign" .. type
          vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end
      '';
    };
}
