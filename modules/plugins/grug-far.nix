{ self, ... }:
{
  flake.modules.plugins.grug-far =
    { pkgs, ... }:
    let
      inherit (self.mkKey) mkKeymap;

    in
    {
      plugins.grug-far = {
        enable = true;
        settings = {
          debounceMs = 1000;
          engine = "ripgrep";
          engines = {
            ripgrep = {
              path = "${pkgs.ripgrep}/bin/rg";
              showReplaceDiff = true;
            };
          };
          maxSearchMatches = 2000;
          maxWorkers = 8;
          minSearchChars = 1;
          normalModeSearch = false;
        };
      };
      keymaps = [
        (mkKeymap "n" "<leader>rs" "<cmd>GrugFar<cr>" "Search and Replace")
      ];
    };
}
