{
  flake.modules.visual.catppuccin =
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
              rosewater = "#e8c4d8";
              flamingo = "#d4b0d8";
              red = "#f4a8b8";
              maroon = "#d4a8c0";
              pink = "#c8b0e8";
              peach = "#f2b8a0";
              yellow = "#f6d88a";
              mauve = "#ff7a6b";
              green = "#b8db8c";
              teal = "#7cb8d4";
              sky = "#8fd4b5";
              sapphire = "#a8c8f0";
              blue = "#7d75c0";
              lavender = "#c5c0ff";
              text = "#cfd3e7";
              subtext1 = "#b7bdd6";
              subtext0 = "#8c92aa";
              overlay2 = "#eba0ac";
              overlay1 = "#454545";
              overlay0 = "#787878";
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
