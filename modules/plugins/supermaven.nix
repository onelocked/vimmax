{
  exo.mods =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.supermaven-nvim ];
      extraConfigLua = ''
        vim.keymap.set("n", "<Leader>sm", function()
          -- If it hasn't been loaded yet, set it up and start it
          if not _G.SupermavenLoaded then
            require("supermaven-nvim").setup({
              keymaps = {
                accept_suggestion = "<F19>",
                clear_suggestion = "<C-c>",
                accept_word = "<C-Right>",
              },
              ignore_filetypes = { },
              color = {
                suggestion_color = "#85819c",
                cterm = 244,
              },
              log_level = "off",
              disable_inline_completion = false,
              disable_keymaps = false,
            })
            _G.SupermavenLoaded = true
            vim.notify("Supermaven awakened! (sm hehe)", vim.log.levels.INFO)
          else
            -- If it's already set up, just toggle it on/off
            vim.cmd("SupermavenToggle")
          end
        end, { noremap = true, silent = true, desc = "Toggle Supermaven" })
      '';
    };
}
