{ self, ... }:
{
  flake.modules.plugins.hop = {
    plugins.hop = {
      enable = true;
      settings = {
        virtual_cursor = true;
        quit_key = "<Esc>";
        teasing = true;
      };
    };
    keymaps =
      with self.mkKey;
      map (mode: mkKeymap mode "<leader>hw" "<cmd>HopWord<cr>" "Hop to Word") [
        "n"
        "v"
      ];
  };
}
