{
  exo.mods =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.supermaven-nvim ];
      extraConfigLua = ''
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<F19>",
            clear_suggestion = "<C-c>",
            accept_word = "<C-Right>",
          },

          ignore_filetypes = {  },
          color = {
            suggestion_color = "#85819c",
            cterm = 244,
          },
          log_level = "off", -- set to "off" to disable logging completely
          disable_inline_completion = false, -- disables inline completion for use with cmp
          disable_keymaps = false, -- disables built in keymaps for more manual control
        })
      '';
    };
}
