{ self, ... }:
{
  flake.modules.plugins.buffer-manager =
    { pkgs, lib, ... }:

    let
      inherit (self.mkKey) mkKeymap wKeyObj;
      inherit (lib.nixvim) mkRaw;
    in
    {
      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "buffer-manager";
          src = pkgs.fetchFromGitHub {
            owner = "j-morano";
            repo = "buffer_manager.nvim";
            rev = "a0ac2db39c8bd4a2b6ca897f38c88770f90d9323";
            hash = "sha256-dTv5S2PbFEsyETpvf8urH9nHzgc48aMicX9+VH9DKQk=";
          };
          dependencies = [ pkgs.vimPlugins.plenary-nvim ];
        })
      ];
      plugins = {
        harpoon = {
          enable = true;
        };
        bufferline = {
          enable = true;
          settings.options = {
            diagnostics = "nvim_lsp";
            always_show_bufferline = false;
          };
        };
      };

      wKeyList = [
        (wKeyObj [
          "<leader>b"
          ""
          "buffers"
        ])
      ];

      keymaps = [
        (mkKeymap "n" "<leader>b." (
          # lua
          mkRaw ''
            function()
              harpoon = require("harpoon")
              harpoon:list():add()
            end
          ''
        ) "Add File to Harpoon")
        (mkKeymap "n" "<leader>bm" "<cmd>:lua require('buffer_manager.ui').toggle_quick_menu()<cr>"
          "Buffer Manager"
        )
        (mkKeymap "n" "<leader>bb" (
          # lua
          mkRaw ''
            function()
              harpoon = require("harpoon")
              harpoon.ui:toggle_quick_menu(harpoon:list())
            end
          ''
        ) "Harpoon ui")

        (mkKeymap "n" "<leader>bp" "<cmd>:BufferLinePick<cr>" "Buffer Line Pick")
        (mkKeymap "n" "<leader>qc" "<cmd>:bp | bd #<cr>" "Buffer close")

        (mkKeymap "n" "<leader>bc" "<cmd>BufferLineCloseOther<cr>"
          "Buffer close all except the current buffer"
        )

        (mkKeymap "n" "<s-Left>" ":BufferLineCyclePrev<cr>" "Buffer Previous")
        (mkKeymap "n" "<s-Right>" ":BufferLineCycleNext<cr>" "Buffer Next")
      ];

    };
}
