{ self, ... }:
{
  flake.modules.plugins.snacks =
    { lib, ... }:
    let
      inherit (self.mkKey) mkKeymap wKeyObj;
    in
    {
      wKeyList = [
        (wKeyObj [
          "<leader>:"
          ""
          ""
          true
        ])
        (wKeyObj [
          "<leader>s"
          ""
          "search"
        ])
        (wKeyObj [
          "<leader>f"
          ""
          "file/find"
        ])
      ];
      keymaps = [
        (mkKeymap "n" "<leader>.r" "<cmd>:lua Snacks.rename.rename_file()<cr>" "Rename file/variable +lsp")
        (mkKeymap "n" "<leader>gB" "<cmd>:lua Snacks.gitbrowse()<cr>" "Git Browse")
        (mkKeymap "n" "<leader>gf" "<cmd>:lua Snacks.lazygit.log_file()<cr>" "Lazygit Current File History")
        (mkKeymap "n" "<leader>gg" "<cmd>:lua Snacks.lazygit()<cr>" "Lazygit")
        (mkKeymap "n" "<leader>gl" "<cmd>:lua Snacks.lazygit.log()<cr>" "Lazygit Log (cwd)")

        (mkKeymap "n" "<leader>ss" "<cmd>:lua Snacks.picker.smart()<cr>" "Smart")
        (mkKeymap "n" "<leader>s," "<cmd>:lua Snacks.picker.buffers({layout = 'vscode'})<cr>" "Buffers")

        (mkKeymap "n" "<leader>ff" "<cmd>:lua Snacks.picker.files()<cr>" "Find Files")
        (mkKeymap "n" "<leader>f/" "<cmd>:lua Snacks.picker.grep()<cr>" "Grep")
        (mkKeymap "n" "<leader>fr" "<cmd>:lua Snacks.picker.recent()<cr>" "Recent")
        (mkKeymap "n" "<leader>fp" "<cmd>:lua Snacks.picker.projects()<cr>" "Pickers")

        (mkKeymap "n" "<leader>su" (lib.nixvim.mkRaw ''
          function()
            Snacks.picker.undo({
              win = {
                input = {
                  keys = {
                    ["y"] = { "yank_add", mode =  "n" },
                    ["Y"] = { "yank_del", mode =  "n" },
                  },
                },
              },
            })
          end
        '') "Undo")
      ];
    };
}
