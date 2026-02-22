{
  flake.modules.visual.dressing = {
    plugins = {
      dressing = {
        enable = true;
        settings.input.mappings.n = {
          "q" = "Close";
          "k" = "HistoryPrev";
          "j" = "HistoryNext";
        };
      };
    };
  };
}
