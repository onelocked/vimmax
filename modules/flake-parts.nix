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
    { system, pkgs, ... }:
    {
      packages = {
        default = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
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
              ])
              ++ (with self.modules.visual; [
                colorizer
                dashboard
                dressing
                extra-visual
                fidget
                noice
                lualine
                tokyodark
              ])
              ++ [ self.modules.nixvim.core ];
          };
        };
      };
      formatter = pkgs.nixfmt-tree;
    };
}
