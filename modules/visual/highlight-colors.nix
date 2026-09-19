{
  neovim.mods = {
    plugins.highlight-colors = {
      enable = true;

      lazyLoad = {
        enable = true;
        settings = {
          event = [
            "BufReadPost"
            "BufNewFile"
          ];
        };
      };

      settings = {
        enable_named_colors = true;
        render = "background";
        virtual_symbol = "■";
      };
    };
  };
}
