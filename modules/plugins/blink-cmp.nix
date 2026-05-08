{
  m.plugins.blink-cmp =
    { pkgs, ... }:
    {
      extraPlugins = with pkgs.vimPlugins; [
        blink-cmp
        blink-ripgrep-nvim
      ];

      extraConfigLua = ''
        require('blink.cmp').setup({
          sources = {
            default = { "lsp", "path", "snippets", "buffer", "ripgrep", "codeium" },
            providers = {
              snippets = {
                    score_offset = 1000,
                  },
              ripgrep = {
                module = "blink-ripgrep",
                name = "Ripgrep",
                score_offset = 100,
                opts = {
                  prefix_min_len = 3,
                  context_size = 5,
                  max_filesize = "1M",
                  project_root_marker = ".git",
                  project_root_fallback = true,
                  search_casing = "--ignore-case",
                },
              },
              codeium = {
                name = "codeium",
                module = "codeium.blink",
                score_offset = 150,
                async = true;
                min_chars = 3;
              },
            },
          },
          completion = {
            list = { selection = { preselect = true } },
            menu = { border = "rounded" },
            documentation = {
              auto_show = false,
              auto_show_delay_ms = 0,
            },
          },
          snippets = { preset = "luasnip" },
          keymap = {
            preset = 'default',
            ['<Tab>'] = { 'accept', 'fallback' },
          },
        })
      '';
    };
}
