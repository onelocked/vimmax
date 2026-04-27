{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
  systems = import inputs.systems;

  perSystem =
    {
      system,
      pkgs,
      ...
    }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      packages = {
        default = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          inherit pkgs;
          module = {
            imports =
              (with self.modules.plugins; [
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
                windsurf
                # grug-far
                cord
                hop
                silicon
                # visual-multi
              ])
              ++ (with self.modules.visual; [
                highlight-colors
                dashboard
                dressing
                extra-visual
                fidget
                noice
                lualine
                catppuccin
              ])
              ++ [ self.modules.nixvim.core ];
          };
        };
      };
      formatter = pkgs.nixfmt-tree;
    };
}
