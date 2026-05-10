{
  m.plugins.trouble =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.trouble-nvim ];
      extraConfigLua = # lua
        ''
          require('trouble').setup({
            modes = {
              symbols = {
                win = { position = "right" },
              },
            },
          })
        '';
    };
}
