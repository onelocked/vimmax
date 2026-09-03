{
  exo.mods =
    { pkgs, ... }:
    {
      plugins.kitty-scrollback = {
        enable = true;
        package = pkgs.vimPlugins.kitty-scrollback-nvim;
      };
    };
}
