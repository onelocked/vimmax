{
  neovim.mods = {
    plugins.trouble = {
      enable = true;
      settings = {
        modes = {
          symbols = {
            win = {
              position = "right";
            };
          };
        };
      };
      lazyLoad = {
        enable = true;
        settings = {
          cmd = [ "Trouble" ];
        };
      };
    };
  };
}
