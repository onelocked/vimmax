{
  outputs =
    inputs:
    inputs.flake-parts.lib.evalFlakeModule { inherit inputs; } {
      imports =
        with inputs.nixpkgs.lib;
        [ ./modules ]
        |> map (fileset.fileFilter (file: file.hasExt "nix" && !hasPrefix "_" file.name))
        |> fileset.unions
        |> fileset.toList;
      _module.args.rootPath = ./.;
    }
    |> (eval: { inherit eval; } // eval.config.processedFlake);

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    systems.url = "github:nix-systems/x86_64-linux";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
  };
}
