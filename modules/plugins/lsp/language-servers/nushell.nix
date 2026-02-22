{
  flake.modules.plugins.lsp = {
    plugins = {
      lsp.servers.nushell = {
        enable = true;
      };
    };
  };
}
