{ self, ... }:
{
  flake.modules.nixvim.core =
    let
      inherit (self.mkKey) mkKeymap wKeyObj;
      v = [
        (mkKeymap "v" "<a-j>" ":m '>+1<cr>gv-gv" "Move Selected Line Down")
        (mkKeymap "v" "<a-k>" ":m '<lt>-2<CR>gv-gv" "Move Selected Line Up")

        (mkKeymap "v" "<" "<gv" "Indent out")
        (mkKeymap "v" ">" ">gv" "Indent in")

        (mkKeymap "v" "<space>" "<Nop>" "Mapped to Nothing")
      ];

      insert = [
        (mkKeymap "i" "jk" "<esc>" "Normal Mode")
        (mkKeymap "i" "<a-j>" "<esc>:m .+1<cr>==gi" "Move Line Down")
        (mkKeymap "i" "<a-k>" "<esc>:m .-2<cr>==gi" "Move Line Up")
      ];

      normal = [
        (mkKeymap "n" "<c-a-=>" "<C-a>" "Increase Number")
        (mkKeymap "n" "<c-a-->" "<C-x>" "Decrease Number")

        (mkKeymap "n" "<a-j>" "<cmd>m .+1<cr>==" "Move line Down")
        (mkKeymap "n" "<a-k>" "<cmd>m .-2<cr>==" "Move line up")

        (mkKeymap "n" "<leader><leader>" "<cmd>nohl<cr>" "no highlight!")
        (mkKeymap "n" "<leader>A" "ggVG" "select All")
      ];
    in
    {
      keymaps = insert ++ normal ++ v;

      # This is list to present icon on which key
      wKeyList = [
        (wKeyObj [
          "<leader>A"
          ""
          ""
          "true"
        ])
        (wKeyObj [
          "<leader><leader>"
          ""
          ""
          "true"
        ])
        (wKeyObj [
          "["
          ""
          "next"
        ])
        (wKeyObj [
          "]"
          ""
          "prev"
        ])
        (wKeyObj [
          "<leader>u"
          "󰔎"
          "ui"
        ])
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

          vim.keymap.set('n', '<6-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
          vim.keymap.set('i', '<6-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
          vim.keymap.set('v', '<6-MiddleMouse>', '<Nop>', { noremap = true, silent = true })
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
