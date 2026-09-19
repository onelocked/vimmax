{
  neovim.mods =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.kitty-scrollback-nvim ];
      extraConfigLua = # lua
        # https://github.com/mikesmithgh/kitty-scrollback.nvim/issues/331#issuecomment-3154964637
        ''
          local autocmds = require("kitty-scrollback.autocommands")
          autocmds.set_yank_post_autocmd = function() end
          require("kitty-scrollback").setup({ })
        '';
    };
}
