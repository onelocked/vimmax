{
  flake.modules.plugins.blink-cmp = {
    plugins = {
      blink-ripgrep.enable = true;
      blink-cmp-words.enable = true;
      blink-cmp = {
        enable = true;
        settings = {
          sources = {
            default = [
              "buffer"
              "lsp"
              "path"
              "ripgrep"
              "dictionary"
              "snippets"
              "codeium"
            ];
            providers = {
              codeium = {
                name = "codeium";
                module = "codeium.blink";
                score_offset = 1000;
              };
              path = {
                score_offset = 300;
              };
              snippets = {
                score_offset = 250;
              };
              lsp = {
                score_offset = 200;
              };
              dictionary = {
                score_offset = 50;
                name = "blink-cmp-words";
                module = "blink-cmp-words.dictionary";
                opts = {
                  dictionary_search_threshold = 3;
                  score_offset = 0;
                  definition_pointers = [
                    "!"
                    "&"
                    "^"
                  ];
                };
              };
              ripgrep = {
                async = true;
                module = "blink-ripgrep";
                name = "Ripgrep";
                score_offset = 100;
                opts = {
                  prefix_min_len = 3;
                  context_size = 5;
                  max_filesize = "1M";
                  project_root_marker = ".git";
                  project_root_fallback = true;
                  search_casing = "--ignore-case";
                  additional_rg_options = { };
                  fallback_to_regex_highlighting = true;
                  ignore_paths = { };
                  additional_paths = { };
                  debug = false;
                };
              };
            };
          };
          # per_filetype = {
          #   text = [ "dictionary" ];
          #   markdown = [ "thesaurus" ];
          # };
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
