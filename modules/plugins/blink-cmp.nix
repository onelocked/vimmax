{
  flake.modules.plugins.blink-cmp = {
    plugins = {
      blink-cmp = {
        enable = true;

        settings = {
          completion.menu.border = "rounded";
          snippets.preset = "luasnip";
          completion = {
            list.selection.preselect = true;
            documentation = {
              auto_show = false;
              auto_show_delay_ms = 0;
            };
          };

          keymap = {
            "<Tab>" = [
              "accept"
              "fallback"
            ];
          };
        };
      };
    };

  };
}
