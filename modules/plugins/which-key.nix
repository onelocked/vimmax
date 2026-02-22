{ self, ... }:
{
  flake.modules.plugins.which-key =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      inherit (self.helpers.onevix.mkKey) mkKeymap;
      inherit (lib.nixvim) mkRaw;
    in
    {
      extraPlugins = with pkgs.vimPlugins; [
        stay-centered-nvim
      ];

      plugins = {
        which-key = {
          enable = true;
          settings.spec = config.wKeyList;
          settings.preset = "helix";
        };
        tmux-navigator.enable = false;
        web-devicons.enable = true;
        lz-n.enable = true;
        mini = {
          enable = true;
          mockDevIcons = true;
          modules = {
            icons = { };
            pairs = { };
            surround = { };
            operators = { };
            bufremove = { };
          };
        };

      };
      keymaps = [
        (mkKeymap "n" "<leader>st" (mkRaw ''
          require('stay-centered').toggle
        '') "Toggle stay-centered.nvim")
      ];
    };
}
