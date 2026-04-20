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
