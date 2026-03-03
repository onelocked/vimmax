{ self, ... }:
{
  flake.modules.plugins.gitsigns =
    { lib, ... }:
    let
      inherit (self.mkKey) mkKeymap;
      inherit (lib.nixvim) mkRaw;
    in
    {
      plugins.gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
          signs = with self.icons.ui; {
            add.text = "${LineLeft}";
            change.text = "${LineLeft}";
            delete.text = "${LineLeft}";
            topdelete.text = "${Triangle}";
            changedelete.text = "${BoldLineLeft}";
          };
        };
      };
      keymaps = [
        # Blame
        (mkKeymap "n" "<leader>gk" (mkRaw "function() require('gitsigns').blame_line({ full = true }) end")
          "Blame Line (Full)"
        )
        (mkKeymap "n" "<leader>gK" ":lua require('gitsigns').blame()<CR>" "Blame File")
      ];

    };
}
