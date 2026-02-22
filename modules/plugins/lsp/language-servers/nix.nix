{
  flake.modules.plugins.lsp =
    { pkgs, ... }:
    {
      plugins.lsp.servers.nixd = {
        enable = true;
        settings.formatting.command = [ "nixfmt" ];
      };

      extraPackages = with pkgs; [
        nixfmt
      ];
    };
}
