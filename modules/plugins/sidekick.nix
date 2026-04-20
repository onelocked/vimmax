{
  flake.modules.plugins.sidekick =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.sidekick-nvim ];
      extraConfigLua = ''
        require("sidekick").setup({
          nes = { enabled = false }, -- Disable Next Edit Suggestions
          cli = {
            picker = "snacks",
            mux = {
              enabled = true,
              backend = "tmux",
            },
          },
        })
        -- Sidekick Keymaps
        vim.keymap.set({ "n", "x" }, "<leader>oc", "<cmd>Sidekick cli select<cr>", { desc = "Sidekick: select tool" })
        vim.keymap.set({ "n", "x" }, "<leader>op", "<cmd>Sidekick cli prompt<cr>", { desc = "Sidekick: select prompt" })

        -- Custom AI Ask (leader-a) using Snacks.input
        vim.keymap.set({ "n", "x" }, "<leader>a", function()
          local is_visual = vim.fn.mode():match("[vV]")
          local target = is_visual and "{this}" or ("@" .. vim.fn.expand("%:."))
          Snacks.input({
            prompt = "AI Ask (" .. (is_visual and "selection" or "file") .. "): ",
          }, function(input)
            if input and input ~= "" then
              -- Use Sidekick CLI send. msg={this} handles visual selection automatically.
              require("sidekick.cli").send({ msg = input .. "\n" .. target, submit = true })
            end
          end)
        end, { desc = "Sidekick: Ask AI" })
      '';
    };
}
