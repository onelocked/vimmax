{
  neovim.mods = {
    plugins.supermaven = {
      enable = true;
      settings = {
        keymaps = {
          accept_suggestion = "<F19>";
          clear_suggestion = "<C-c>";
          accept_word = "<C-Right>";
        };
        ignore_filetypes = { };
        color = {
          suggestion_color = "#85819c";
          cterm = 244;
        };
        log_level = "off";
        disable_inline_completion = false;
        disable_keymaps = false;
      };
      lazyLoad = {
        enable = true;
        settings = {
          keys = [
            {
              __unkeyed-1 = "<leader>sm";
              __unkeyed-2 = "<cmd>SupermavenToggle<cr>";
              desc = "Toggle Supermaven";
            }
          ];
        };
      };
    };
  };
}
