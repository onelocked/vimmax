{ self, ... }:
{
  flake.homeManagerModules.default =
    {

      pkgs,
      lib,
      config,
      ...
    }:
    let
      cfg = config.programs.vimmax;
      inherit (pkgs.stdenv.hostPlatform) system;
      vimmaxPkg = self.packages.${system}.default;
      inherit (lib)
        mkEnableOption
        mkOption
        mkIf
        types
        ;
    in
    {
      options.programs.vimmax = {

        enable = mkEnableOption "Vimmax Editor";

        package = mkOption {
          type = types.package;
          default = vimmaxPkg;
          defaultText = lib.literalExpression "vimmax";
          description = "The Vimmax package to use.";
        };

        defaultEditor = mkOption {
          type = types.bool;
          default = false;
          description = "Whether to set EDITOR=nvim in session variables.";
        };
      };

      config = mkIf cfg.enable {
        home = {
          packages = [ cfg.package ];
          sessionVariables = mkIf cfg.defaultEditor {
            EDITOR = "nvim";
          };
        };
      };
    };
}
