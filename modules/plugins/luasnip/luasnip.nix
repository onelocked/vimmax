{
  flake.modules.plugins.luasnip = {
    plugins = {
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
        };
        fromVscode = [
          { }
          { paths = ./snippets; }
        ];
      };
      friendly-snippets = {
        enable = true;
      };
    };
  };
}
