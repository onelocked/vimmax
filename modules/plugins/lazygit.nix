{ self, ... }:
{
  flake.modules.plugins.lazygit =
    { lib, ... }:
    let
      inherit (lib.nixvim) mkRaw;
      inherit (self.mkKey) mkKeymap;
    in
    {
      plugins.lazygit = {
        enable = true;
      };

      keymaps = [
        (mkKeymap "n" "<leader>gg" (mkRaw ''
          function()
            local buf_dir = vim.fn.expand("%:p:h")
            local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
            local cwd = (git_root and vim.v.shell_error == 0) and git_root or buf_dir
            vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
            vim.cmd("LazyGit")
          end
        '') "LazyGit")
      ];
    };
}
