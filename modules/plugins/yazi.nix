{ self, ... }:
{
  flake.modules.plugins.yazi = {

    plugins = {
      yazi = {
        enable = true;
        settings = {
          enable_mouse_support = false;
          floating_window_scaling_factor = 0.8;
          open_for_directories = true;
          yazi_floating_window_border = "single";
        };

      };
    };
    keymaps =
      let
        inherit (self.mkKey) mkKeymap;
      in
      [
        (mkKeymap "n" "<leader>y" "<cmd>Yazi<cr>" "Open Yazi")
      ];

  };
}
