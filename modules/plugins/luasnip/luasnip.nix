{
  neovim.mods = {
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
        lazyLoad = {
          enable = true;
          settings = {
            event = [ "InsertEnter" ];
          };
        };
      };
      friendly-snippets = {
        enable = true;
      };
    };
  };
}
