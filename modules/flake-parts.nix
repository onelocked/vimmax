{ inputs, self, ... }:
{
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
            imports = with self.modules.plugins; [
              blink-cmp
            ];
          };
        };
      };

      formatter = pkgs.nixfmt-tree;
    };
}
