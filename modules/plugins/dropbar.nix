{
  m.plugins.dropbar =
    { pkgs, ... }:
    {
      extraPlugins = with pkgs.vimPlugins; [ dropbar-nvim ];
      extraConfigLua = ''
        require('dropbar').setup({
          general = {
            attach_events = {
              'BufWinEnter',
              'BufWritePost',
            },
          },
        })
      '';
    };
}
