{ self, ... }:
{
  flake.modules.plugins.silicon =
    { pkgs, lib, ... }:
    let
      inherit (self.mkKey) mkKeymap;
    in
    {
      extraPlugins = [ pkgs.vimPlugins.nvim-silicon ];

      extraConfigLua = # lua
        ''
          require("nvim-silicon").setup({
            font = "Maple Mono NF=30",
            theme = "gruvbox-dark",
            window_title = "code snippet by onelock",
            line_pad = 3,
            tab_width = 10,
            to_clipboard = true,
            shadow_blur_radius = 40,
            pad_horiz = 30,
            pad_vert = 30,
            gobble = true,
            command = "silicon",
            background = "#504945",
            shadow_color = "#1d2021",
            line_offset = 1,
            shadow_offset_x = 8,
            shadow_offset_y = 8,
          })

          -- Copy selected visual block to clipboard in a markdown block with correct language selected
          vim.keymap.set("v", "<leader>sc", function()
            -- Force leaving visual mode to update marks
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
            vim.schedule(function()
              local start_row = vim.fn.getpos("'<")[2]
              local end_row = vim.fn.getpos("'>")[2]
              local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)

              -- Default to filetype
              local lang = vim.bo.filetype

              -- Try to detect an injected language via treesitter
              local ok, parser = pcall(vim.treesitter.get_parser, 0)
              if ok and parser then
                parser:parse(true)
                -- Walk the language tree and find the deepest child whose range
                -- contains the start of the selection
                local row = start_row - 1
                local col = 0
                local function find_lang(langtree)
                  local result = nil
                  for _, child in pairs(langtree:children()) do
                    for _, tree in ipairs(child:trees()) do
                      local srow, scol, erow, ecol = tree:root():range()
                      local after_start = row > srow or (row == srow and col >= scol)
                      local before_end = row < erow or (row == erow and col <= ecol)
                      if after_start and before_end then
                        result = child:lang()
                        local deeper = find_lang(child)
                        if deeper then result = deeper end
                      end
                    end
                  end
                  return result
                end
                local injected = find_lang(parser)
                if injected then lang = injected end
              end

              local content = "```" .. lang .. "\n" .. table.concat(lines, "\n") .. "\n```"
              vim.fn.setreg("+", content)
              vim.notify("Copied as ```" .. lang .. " code block")
            end)
          end, { desc = "Copy selection as markdown code block" })
        '';

      keymaps = [
        (mkKeymap [ "v" ] "<leader>ss" (lib.nixvim.mkRaw ''function() require("nvim-silicon").clip() end'')
          "Copy screenshot to clipboard"
        )
      ];
    };
}
