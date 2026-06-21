{
  exo.mods =
    { lib, pkgs, ... }:
    {
      plugins = {
        nix.enable = true;
        lsp.servers.nixd = {
          enable = true;
        };
        conform-nvim.settings = {
          formatters_by_ft.nix = [ "nixfmt" ];
          formatters.nixfmt.command = lib.getExe pkgs.nixfmt-rs;
        };
      };
      extraPackages = with pkgs; [
        nixfmt-rs
      ];
    };
}
