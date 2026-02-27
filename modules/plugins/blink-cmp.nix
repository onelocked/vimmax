{
  flake.modules.plugins.blink-cmp = {
    plugins = {
      blink-cmp-spell.enable = true;
      blink-cmp = {
        enable = true;

        settings = {
          sources = {
            sources.default = [
              "lsp"
              "path"
              "luasnip"
              "buffer"
              "spell"
            ];
          };
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
