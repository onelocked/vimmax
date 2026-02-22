{ self, ... }:
{
  flake.modules.plugins.gitsigns =
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
    };
}
