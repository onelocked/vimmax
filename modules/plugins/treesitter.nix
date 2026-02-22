{
  flake.modules.plugins.treesitter =
    { pkgs, ... }:
    {
      plugins = {
        treesitter = {
          enable = true;
          settings = {
            indent.enable = true;
            folding.enable = true;
            autopairs.enable = true;
            incremental_selection.enable = true;
            highlight = {
              enable = true;
              disable = [
                "markdown"
              ];
            };
            grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
            auto_install = false;
            ensureInstalled = [
              "nix"
              "qmljs"
            ];
          };
        };
        ts-autotag = {
          enable = true;
        };

        ts-context-commentstring = {
          enable = true;
          disableAutoInitialization = false;
        };
      };
    };
}
