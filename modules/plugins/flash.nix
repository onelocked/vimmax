{
  neovim.mods =
    { mkRaw, ... }:
    {
      plugins.flash = {
        enable = true;
        settings.modes.char.enabled = false;
      };
      keymaps =
        map
          (mode: {
            mode = mode;
            key = "<leader>fs";
            action = (
              mkRaw ''
                function()
                  require('flash').jump({
                    forward = true, wrap = true, multi_window = true
                  })
                end
              ''
            );
            options = {
              desc = "Flash Search";
              silent = true;
              noremap = true;
            };
          })
          [
            "n"
            "v"
          ];
    };
}
