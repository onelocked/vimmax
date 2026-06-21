{
  exo.mods =
    { pkgs, ... }:
    {
      extraPackages = [ pkgs.sqlite ];
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "time-tracker.nvim";
          src = pkgs.fetchFromGitHub {
            owner = "3rd";
            repo = "time-tracker.nvim";
            rev = "4127c4b5fecaf5f5cb3aa840707e58bb88eb9bf0";
            hash = "sha256-zWrQAV5OmlI9nwd/UsY6rFfbLQWja0p23e3FO1vsbUw=";
          };
          doCheck = false;

          dependencies = [
            (pkgs.vimUtils.buildVimPlugin {
              name = "sqlite.nvim";
              src = pkgs.fetchFromGitHub {
                owner = "3rd";
                repo = "sqlite.nvim";
                rev = "a8466c830a89794c2eafa41b41dd11fdf4a0d7ca";
                hash = "sha256-MLSB9i0H3H0bU6cbJOtl+eh34aMrAsdCgpoMB/yg41E=";
              };
              doCheck = false;
            })
          ];
        })
      ];
      extraConfigLua = ''
        require("time-tracker").setup({
          data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
          tracking_events = { "BufEnter", "BufWinEnter", "CursorMoved", "CursorMovedI", "WinScrolled" },
          tracking_timeout_seconds = 5 * 60, -- 5 minutes
        })
      '';
    };
}
