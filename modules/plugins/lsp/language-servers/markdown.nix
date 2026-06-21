{
  exo.mods = {
    plugins = {
      render-markdown = {
        enable = true;
        lazyLoad.settings.ft = "markdown";
      };
      markdown-preview.enable = true;
      glow = {
        enable = true;
        lazyLoad.settings = {
          ft = "markdown";
          cmd = "Glow";
        };
      };
    };
  };
}
