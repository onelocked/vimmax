{ self, ... }:
{
  flake.modules.plugins.flash =
    { lib, ... }:
    let
      inherit (self.mkKey) mkKeymap;
      inherit (lib.nixvim) mkRaw;
    in

    {
      plugins.flash = {
        enable = true;
        settings.modes.char.enabled = false;
      };
      keymaps = [
        (mkKeymap "n" "<leader>fs" (
          # lua
          mkRaw ''
            function()
              require('flash').jump({
                forward = true, wrap = true, multi_window = true
              })
              end
          ''
        ) "Flash Search")
      ];
    };
}
