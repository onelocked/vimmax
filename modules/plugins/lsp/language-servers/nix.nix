{
  exo.mods =
    { pkgs, ... }:
    {
      plugins = {
        nix.enable = true;
        lsp.servers.nixd = {
          enable = true;
        };
        conform-nvim.settings = {
          formatters_by_ft.nix = [ "nixfmt" ];
        };
      };
      extraPackages = with pkgs; [ nixfmt-rs ];
    };
}
