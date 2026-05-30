{
  m.plugins.which-key =
    { config, ... }:
    {

      plugins = {
        which-key = {
          enable = true;
          settings.spec = config.wKeyList;
          settings.preset = "helix";
        };
        tmux-navigator.enable = false;
        web-devicons.enable = true;
        lz-n.enable = true;
        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            icons = { };
            pairs = { };
            surround = { };
            operators = { };
            bufremove = { };
          };
        };

      };
    };
}
