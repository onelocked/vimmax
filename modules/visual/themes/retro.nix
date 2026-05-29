{
  m.visual.retro =
    { lib, ... }:
    let
      inherit (lib.nixvim) mkRaw;
    in
    {
      colorschemes.catppuccin = {
        enable = true;
        settings = {
          color_overrides = {
            mocha = {
              rosewater = "#6e1278";
              flamingo = "#9c3010";
              red = "#b80018";
              maroon = "#620030";
              pink = "#920070";
              peach = "#8c4a00";
              yellow = "#685500";
              mauve = "#a20b27";
              green = "#0a6806";
              teal = "#006055";
              sky = "#0033c4";

              sapphire = "#005a8e";
              blue = "#183870";
              lavender = "#3e0087";

              text = "#151515";
              subtext1 = "#252525";
              subtext0 = "#363636";
              overlay2 = "#3d4c88";
              overlay1 = "#737373";
              overlay0 = "#383838";
              surface2 = "#a0a0a0";
              surface1 = "#afafaf";
              surface0 = "#b8b8b8";
              base = "#bcbcba";
              mantle = "#c6c6c6";
              crust = "#d4d4d4";
            };
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
