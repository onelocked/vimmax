{
  inputs,
  config,
  lib,
  ...
}:
{
  config = {
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
        formatter = pkgs.nixfmt-rs;
        packages = {
          default = inputs'.nixvim.legacyPackages.makeNixvimWithModule {
            inherit pkgs;
            module = {
              imports = with config.exo; [
                core
                mods
                visual
              ];
            };
          };
        };
      };
  };
  options.exo = {
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
}
