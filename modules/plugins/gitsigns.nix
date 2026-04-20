{ self, ... }:
{
  flake.modules.plugins.gitsigns =
    { lib, pkgs, ... }:
    let
      inherit (self.mkKey) mkKeymap;
      inherit (lib.nixvim) mkRaw;
      inherit (self.icons.ui) LineLeft Triangle BoldLineLeft;
    in
    {
      extraPlugins = [ pkgs.vimPlugins.gitsigns-nvim ];

      extraConfigLua = # lua
        ''
          require('gitsigns').setup({
            current_line_blame = true,
            current_line_blame_opts = {
              delay = 300,           -- default 1000ms feels sluggish
              virt_text_pos = 'eol', -- or 'right_align'
              ignore_whitespace = false,
            },
            current_line_blame_formatter = '<author>, <author_time:%R> • <summary>',
            attach_to_untracked = true,  -- show signs in new files too
            signs_staged_enable = true,  -- different signs for staged vs unstaged

            word_diff = false,
            signs = {
              add = { text = '${LineLeft}' },
              change = { text = '${LineLeft}' },
              delete = { text = '${LineLeft}' },
              topdelete = { text = '${Triangle}' },
              changedelete = { text = '${BoldLineLeft}' },
            },
            preview_config = {
              border = 'rounded',
              style = 'minimal',
              relative = 'cursor',
              row = 0,
              col = 1
            },
          })
        '';

      keymaps = [
        (mkKeymap "n" "<leader>gk" (mkRaw "function() require('gitsigns').blame_line({ full = true }) end")
          "Blame Line (Full)"
        )
        (mkKeymap "n" "<leader>gK" ":lua require('gitsigns').blame()<CR>" "Blame File")
        (mkKeymap "n" "<leader>gf"
          (mkRaw "function() require('gitsigns').toggle_linehl(); require('gitsigns').toggle_deleted() end")
          "Toggle Inline Diff"
        )
      ];
    };
}
