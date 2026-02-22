{ self, ... }:
{
  flake.modules.plugins.lsp =
    { lib, ... }:
    let
      inherit (self.mkKey) mkKeymap wKeyObj;
    in
    {

      plugins = {
        mini.modules.comment = {
          mappings = {
            comment = "<leader>/";
            comment_line = "<leader>/";
            comment_visual = "<leader>/";
            ignore_blank_line = true;
          };
        };
        trim.enable = true;
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            harper_ls.enable = false;
            typos_lsp = {
              enable = true;
              extraOptions.init_options.diagnosticSeverity = "Hint";
            };
          };
          keymaps = {
            silent = true;
            diagnostic = {
              "<leader>lj" = "goto_next";
              "<leader>lk" = "goto_prev";
            };
          };
        };
      };

      diagnostic.settings = {
        virtual_text = true;
        underline = true;
        signs = true;
        severity_sort = false;
        float = {
          border = "rounded";
          source = "always";
          focusable = false;
        };
      };
      autoCmd = [
        {
          event = [ "CursorHold" ];
          desc = "lsp show diagnostics on CursorHold";
          callback =
            lib.nixvim.mkRaw # lua

              ''
                function()
                 local hover_opts = {
                    focusable = false,
                    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                    border = "rounded",
                    source = "always",
                  }
                  vim.diagnostic.open_float(nil, hover_opts)
                end
              '';
        }
      ];
      wKeyList = [
        (wKeyObj [
          "<leader>l"
          "󰿘"
          "lsp"
        ])
      ];

      plugins.lsp.keymaps.extra = [
        (mkKeymap "n" "<leader>lD" "<cmd>:lua Snacks.picker.lsp_definitions()<cr>" "Definitions list")
        (mkKeymap "n" "<leader>ls" "<cmd>:lua Snacks.picker.lsp_symbols()<cr>" "Definitions list")

        (mkKeymap "n" "<leader>lf" "<cmd>:lua require('conform').format()<cr>" "Format file")
      ];
    };
}
