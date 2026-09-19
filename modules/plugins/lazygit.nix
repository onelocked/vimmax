{
  neovim.mods =
    { pkgs, mkRaw, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.lazygit-nvim ];

      extraConfigLua = # lua
        ''
          vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }
        '';

      plugins.lz-n.plugins = [
        {
          __unkeyed-1 = "lazygit.nvim";
          cmd = [
            "LazyGit"
            "LazyGitCurrentFile"
            "LazyGitFilter"
            "LazyGitFilterCurrentFile"
          ];
          keys = [ "<leader>gg" ];
        }
      ];

      keymaps = [
        {
          mode = "n";
          key = "<leader>gg";
          action = mkRaw ''
            function()
              local buf_dir = vim.fn.expand("%:p:h")
              local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
              local cwd = (git_root and vim.v.shell_error == 0) and git_root or buf_dir
              vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
              vim.cmd("LazyGit")
            end
          '';
          options = {
            desc = "LazyGit";
            silent = true;
            noremap = true;
          };
        }
        {
          mode = "n";
          key = "<leader>gl";
          action = "<cmd>lua Snacks.lazygit.log_file()<cr>";
          options = {
            desc = "Lazygit Current File History";
            silent = true;
            noremap = true;
          };
        }
      ];
    };
}
