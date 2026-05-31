{ self, ... }:
{
  m.plugins.hop =
    { theme, lib, ... }:
    {
      extraConfigLua = ''
        ${lib.optionalString (theme == "light") # lua
          ''
            vim.api.nvim_set_hl(0, "HopUnmatched", { fg = "#000000" })
            vim.api.nvim_create_autocmd("ColorScheme", {
              pattern = "*",
              callback = function()
                vim.api.nvim_set_hl(0, "HopUnmatched", { fg = "#000000" })
              end,
            })
          ''
        }
      '';

      plugins.hop = {
        enable = true;
        settings = {
          virtual_cursor = true;
          quit_key = "<Esc>";
          teasing = true;
        };
      };
      keymaps =
        with self.mkKey;
        map (mode: mkKeymap mode "<leader>hw" "<cmd>HopWord<cr>" "Hop to Word") [
          "n"
          "v"
        ];
    };
}
