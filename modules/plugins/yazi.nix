{ self, ... }:
{
  flake.modules.plugins.yazi = {

    plugins = {
      yazi.enable = true;
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
