{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    inputs.flake-parts.flakeModules.modules
    (lib.mkAliasOptionModule [ "m" ] [ "flake" "modules" ])
  ];
  systems = import inputs.systems;

  perSystem =
    {
      system,
      pkgs,
      inputs',
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      packages = {
        default = lib.makeOverridable (
          {
            theme ? "dark",
          }:
          inputs'.nixvim.legacyPackages.makeNixvimWithModule {
            inherit pkgs;
            module = {
              _module.args = { inherit theme; };
              imports =
                (with config.m.plugins; [
                  blink-cmp
                  which-key
                  snacks
                  options
                  buffer-manager
                  flash
                  gitsigns
                  lsp
                  luasnip
                  todo-comments
                  treesitter
                  yazi
                  lazygit
                  sidekick
                  cord
                  hop
                  silicon
                  time-tracker
                  supermaven
                  trouble
                ])
                ++ (with config.m.visual; [
                  highlight-colors
                  dashboard
                  dressing
                  extra-visual
                  fidget
                  noice
                  lualine
                  (if theme == "light" then retro else catppuccin)
                ])
                ++ [ config.m.nixvim.core ];
            };
          }
        ) { };
      };
      formatter = pkgs.nixfmt-rs;
    };
}
