{
  flake.modules.plugins.lazygit =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.lazygit-nvim ];
      extraConfigLua = ''
        vim.g.lazygit_floating_window_border_chars = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' }

        vim.keymap.set('n', '<leader>gg', function()
          local buf_dir = vim.fn.expand("%:p:h")
          local git_root = vim.fn.systemlist("git -C " .. vim.fn.shellescape(buf_dir) .. " rev-parse --show-toplevel")[1]
          local cwd = (git_root and vim.v.shell_error == 0) and git_root or buf_dir
          vim.cmd("lcd " .. vim.fn.fnameescape(cwd))
          vim.cmd("LazyGit")
        end, { desc = "LazyGit" })
      '';
    };
}
