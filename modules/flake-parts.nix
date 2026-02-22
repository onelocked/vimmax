{ inputs, ... }:
{

  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  perSystem =
    { system, ... }:
    let
      nixvimLib = inputs.nixvim.lib.${system};
      nixvim' = inputs.nixvim.legacyPackages.${system};
      nixvimModule = {
        inherit system;
        module = import ./vix;
        extraSpecialArgs = {
          inherit inputs;
        };
      };
      nvim = nixvim'.makeNixvimWithModule nixvimModule;
    in
    {
      checks = {
        default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
      };

      packages = {
        default = nvim;
      };

      formatter = inputs.nixpkgs.nixfmt-tree;
    };
}
