{
  exo.mods = {
    plugins = {
      which-key = {
        enable = true;
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
