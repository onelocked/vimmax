{
  flake.modules.visual.highlight-colors = {
    plugins.highlight-colors = {
      enable = true;
      settings = {
        enable_named_colors = true;
        render = "background";
        virtual_symbol = "■";
      };
    };
  };
}
