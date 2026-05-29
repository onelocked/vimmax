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
              rosewater = "#8e2a46";
              flamingo = "#842844";
              red = "#9e1c1c";
              maroon = "#7a1830";
              pink = "#782858";
              peach = "#9e4e00";
              yellow = "#6b6100";
              mauve = "#5c2488";
              green = "#246628";
              teal = "#005959";
              sky = "#22634e";

              sapphire = "#10587a";
              blue = "#183870";
              lavender = "#502888";

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
