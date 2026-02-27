{
  flake.modules.plugins.cord = {
    plugins.cord = {
      enable = true;
      settings = {
        display = {
          flavor = "dark";
          theme = "catppuccin";
        };
        editor = {
          tooltip = "Neovim";
        };
        idle = {
          enabled = true;
          timeout = 900000;
        };
        text = {
          workspace = "";
        };
        timestamp = {
          reset_on_idle = true;
        };
      };
    };

  };
}
