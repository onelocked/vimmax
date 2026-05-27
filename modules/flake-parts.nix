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
        default = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
          inherit pkgs;
          module = {
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
                # windsurf
                # grug-far
                cord
                hop
                silicon
                time-tracker
                supermaven
                # dropbar
                trouble
                #navic
                # visual-multi
                #opencode
              ])
              ++ (with config.m.visual; [
                highlight-colors
                dashboard
                dressing
                extra-visual
                fidget
                noice
                lualine
                # catppuccin
                retro
              ])
              ++ [ config.m.nixvim.core ];
          };
        };
      };
      formatter = pkgs.nixfmt-rs;
    };
}
