{
  exo.core = {
    keymaps = [
      {
        mode = "v";
        key = "<a-j>";
        action = ":m '>+1<cr>gv-gv";
        options = {
          desc = "Move Selected Line Down";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = "<a-k>";
        action = ":m '<lt>-2<CR>gv-gv";
        options = {
          desc = "Move Selected Line Up";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options = {
          desc = "Indent out";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options = {
          desc = "Indent in";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "v";
        key = "<space>";
        action = "<Nop>";
        options = {
          desc = "Mapped to Nothing";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "i";
        key = "jk";
        action = "<esc>";
        options = {
          desc = "Normal Mode";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "i";
        key = "<a-j>";
        action = "<esc>:m .+1<cr>==gi";
        options = {
          desc = "Move Line Down";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "i";
        key = "<a-k>";
        action = "<esc>:m .-2<cr>==gi";
        options = {
          desc = "Move Line Up";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<c-a-=>";
        action = "<C-a>";
        options = {
          desc = "Increase Number";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<c-a-->";
        action = "<C-x>";
        options = {
          desc = "Decrease Number";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<a-j>";
        action = "<cmd>m .+1<cr>==";
        options = {
          desc = "Move line Down";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<a-k>";
        action = "<cmd>m .-2<cr>==";
        options = {
          desc = "Move line up";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<leader><leader>";
        action = "<cmd>nohl<cr>";
        options = {
          desc = "no highlight!";
          silent = true;
          noremap = true;
        };
      }
      {
        mode = "n";
        key = "<leader>A";
        action = "ggVG";
        options = {
          desc = "select All";
          silent = true;
          noremap = true;
        };
      }
    ];

    extraConfigLua = # lua
      ''
        -- Disable Middle Mouse paste (PRESS)
        vim.keymap.set('n', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        -- Disable multi-click middle mouse
        vim.keymap.set('n', '<2-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<2-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<2-MiddleMouse>', '<Nop>', { noremap = true, silent = true })

        vim.keymap.set('n', '<3-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<3-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<3-MiddleMouse>', '<Nop>', { noremap = true, silent = true })

        vim.keymap.set('n', '<4-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<4-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<4-MiddleMouse>', '<Nop>', { noremap = true, silent = true })

        vim.keymap.set('n', '<5-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<5-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<5-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
        -- Disable middle mouse drag just in case
        vim.keymap.set('n', '<MiddleDrag>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('i', '<MiddleDrag>', '<Nop>', { noremap = true, silent = true })
        vim.keymap.set('v', '<MiddleDrag>', '<Nop>', { noremap = true, silent = true })


        -- Use black hole register for 'x', 'X', 'c', 'C'
        vim.api.nvim_set_keymap('n', 'x', '"_x', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'X', '"_X', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'c', '"_c', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('n', 'C', '"_C', { noremap = true, silent = true })

        -- Visual mode
        vim.api.nvim_set_keymap('v', 'x', '"_d', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', 'X', '"_d', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', 'c', '"_c', { noremap = true, silent = true })
        vim.api.nvim_set_keymap('v', 'C', '"_c', { noremap = true, silent = true })

        -- In visual mode, paste from the clipboard without overwriting it
        vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

        -- Only this hack works in command mode
        vim.cmd([[
          cnoremap <C-j> <C-n>
          cnoremap <C-k> <C-p>
        ]])
      '';
  };
}
