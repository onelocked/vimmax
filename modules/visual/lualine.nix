{
  m.visual.lualine =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.lualine-nvim ];
      extraConfigLua = ''
        local symbols = nil
        local function get_symbols()
          if not symbols and package.loaded["trouble"] then
            symbols = require("trouble").statusline({
              mode = "symbols",
              groups = {},
              title = false,
              filter = { range = true },
              format = "{kind_icon}{symbol.name:Normal}",
              hl_group = "lualine_c_normal",
            })
          end
          return symbols
        end

        require('lualine').setup({
          options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = {
              left = "",
              right = "",
            },
            section_separators = {
              left = "",
              right = "",
            },
            disabled_filetypes = {
              statusline = { "alpha", "dashboard", "snacks_dashboard" },
              winbar = { },
            },
            ignore_focus = { },
            always_divide_middle = true,
            always_show_tabline = true,
            globalstatus = true,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = {
              "branch",
              "diff",
              "diagnostics",
            },
            lualine_c = {
              "filename",
              {
                function()
                  local s = get_symbols()
                  return s and s.get()
                end,
                cond = function()
                  local s = get_symbols()
                  return vim.bo.buftype == "" and s and s.has()
                end,
              },
            },
            lualine_x = {
              "encoding",
              "fileformat",
              "filetype",
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = { },
            lualine_b = { },
            lualine_c = { "filename" },
            lualine_x = { "location" },
            lualine_y = { },
            lualine_z = { },
          },
          tabline = { },
          winbar = { },
          inactive_winbar = { },
          extensions = { },
        })
      '';
    };
}
