{
  exo.mods =
    {
      pkgs,
      lib,
      config,
      ...
    }:

    let
      inherit (config.vimmax.mkKey) mkKeymap wKeyObj;
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
          settings = {
            options = {
              diagnostics = "nvim_lsp";
              always_show_bufferline = false;
              themable = false;
            };
            highlights = {
              fill = { bg = "NONE"; };
              background = { bg = "NONE"; };
              buffer_visible = { bg = "NONE"; };
              buffer_selected = { bg = "NONE"; bold = true; };
              close_button = { bg = "NONE"; };
              close_button_visible = { bg = "NONE"; };
              close_button_selected = { bg = "NONE"; };
              separator = { bg = "NONE"; };
              separator_visible = { bg = "NONE"; };
              separator_selected = { bg = "NONE"; };
              indicator_selected = { bg = "NONE"; fg = config.vimmax.${config.vimmax.theme}.base08; };
              indicator_visible = { bg = "NONE"; };
              modified = { bg = "NONE"; };
              modified_visible = { bg = "NONE"; };
              modified_selected = { bg = "NONE"; };
              duplicate = { bg = "NONE"; };
              duplicate_visible = { bg = "NONE"; };
              duplicate_selected = { bg = "NONE"; };
            };
          };
        };
      };

      vimmax.wKeyList = [
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
