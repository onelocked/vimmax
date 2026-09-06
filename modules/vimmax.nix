{
  inputs,
  config,
  lib,
  ...
}:
{
  config = {
    tack.inputs = {
      nixpkgs = "gh:nixos/nixpkgs/nixos-unstable";
      nixvim = "gh:nix-community/nixvim";
    };
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
        formatter = pkgs.nixfmt-rs;
        packages = {
          default =
            (inputs.nixvim.lib.evalNixvim {
              inherit system;
              extraSpecialArgs = { inherit inputs; };
              modules = with config.exo; [
                core
                mods
                visual
                { nixpkgs.source = inputs.nixpkgs; }
              ];
            }).config.build.package;
        };
      };
  };
  options = {
    perSystem = lib.mkOption { type = lib.types.deferredModule; };
    systems = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [ "x86_64-linux" ];
    };
    exo = {
      mods = lib.mkOption {
        type = lib.types.deferredModule;
      };
      visual = lib.mkOption {
        type = lib.types.deferredModule;
      };
      core = lib.mkOption {
        type = lib.types.deferredModule;
      };
    };
  };
}
