{
  m.visual.forte =
    { lib, config, ... }:
    let
      inherit (lib.nixvim) mkRaw;
      cfg = config.vimmax;
    in
    {
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          color_overrides = {
            mocha = if cfg.theme == "light" then cfg.light else cfg.dark;
          };
          highlight_overrides = {
            mocha =
              #lua
              mkRaw ''
                function(colors)
                  return {
                    Comment = { fg = "#666666", style = { "bold", "italic" } },
                    ["@comment"] = { fg = "#666666", style = { "bold", "italic" } },
                    ["@comment.documentation"] = { fg = "#666666", style = { "bold", "italic" } },

                    -- Fix Line Numbers
                    LineNr = { fg = colors.overlay1 },
                    CursorLineNr = { fg = colors.text, style = { "bold" } },
                    CursorLine = { bg = "#bbbbbb" },

                    -- Fix Git Signs
                    GitSignsAdd = { fg = colors.green, bg = "NONE" },
                    GitSignsChange = { fg = colors.yellow, bg = "NONE" },
                    GitSignsDelete = { fg = colors.red, bg = "NONE" },
                    SignColumn = { bg = "NONE" },

                    -- Classic Mac OS Selection Blue
                    Visual = { bg = "#6699FF", fg = "#ffffff", style = { "bold" } },
                    -- Map keys (flake, options, mkKey) to Violet
                    ["@property"] = { fg = colors.lavender },
                    ["@variable.member"] = { fg = colors.lavender },

                    -- Map functions (mkOption) to a stark, bold Cyan/Blue
                    ["@function"] = { fg = colors.sapphire, style = { "bold" } },
                    ["@function.call"] = { fg = colors.sapphire, style = { "bold" } },

                    -- Pop built-ins/types with high-contrast Orange
                    ["@function.builtin"] = { fg = colors.peach, style = { "bold" } },
                    ["@type.builtin"] = { fg = colors.peach },

                  }
                end
              '';
          };
          flavour = "mocha";
          transparent_background = true;
          disable_underline = false;
          default_integrations = true;
          integrations = {
            noice = true;
            snacks = {
              enabled = false;
            };
            fidget = true;
            flash = true;
            treesitter_context = true;
            hop = true;
            which_key = true;
            blink_cmp = {
              style = "bordered";
            };
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = false;
            nvimtree = true;
            treesitter = true;
          };
          styles = {
            booleans = [
              "bold"
            ];
            conditionals = [
              "bold"
            ];
          };
          term_colors = true;
        };
      };
    };
}
