{
  flake.modules.plugins.lsp =
    { pkgs, ... }:
    {
      plugins = {
        conform-nvim.settings = {
          formatters_by_ft.go = [ "gofmt" ];
        };
        lsp.servers.golangci_lint_ls = {
          enable = true;
          package = pkgs.golangci-lint-langserver;
        };
        lsp.servers.gopls = {
          enable = true;
          package = pkgs.gopls;
        };
      };
      extraPackages = with pkgs; [
        golangci-lint
      ];
    };
}
