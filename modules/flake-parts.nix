{ inputs, self, ... }:
{
  imports = [ inputs.flake-parts.flakeModules.modules ];
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

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
