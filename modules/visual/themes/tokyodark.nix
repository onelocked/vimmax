{
  flake.modules.visual.tokyodark =
    { pkgs, ... }:
    {

      colorscheme = "tokyodark";

      extraPlugins = [
        (pkgs.vimUtils.buildVimPlugin {
          name = "tokyodark";
          src = pkgs.fetchFromGitHub {
            owner = "tiagovla";
            repo = "tokyodark.nvim";
            rev = "cc70a2fb809d5376f2bd8e5836f9bb3f5fb8ef43";
            hash = "sha256-pEnA8s1666HYnHkpN1Xtni+W8vVy+AeUr5z7WY2RLo4=";
          };
        })
      ];
      extraConfigLuaPre = ''
        options = {
          transparent_background = "true",
          gamma = 1.00,                      -- adjust the brightness of the theme
          styles = {
            comments = { italic = true },    -- style for comments
            keywords = { italic = true },    -- style for keywords
            identifiers = { italic = true }, -- style for identifiers
            functions = {},                  -- style for functions
            variables = {},                  -- style for variables
          },
          terminal_colors = true,
          custom_highlights = function(highlights, colors)
            return {
              TelescopeMatching = { fg = colors.orange },
              TelescopeSelection = { fg = colors.fg, bg = colors.bg1, bold = true },
              TelescopePromptPrefix = { bg = colors.bg1 },
              TelescopePromptNormal = { bg = colors.bg1 },
              TelescopeResultsNormal = { bg = colors.bg0 },
              TelescopePreviewNormal = { bg = colors.bg0 },
              TelescopePromptBorder = { bg = colors.bg1, fg = colors.bg1 },
              TelescopeResultsBorder = { bg = colors.bg0, fg = colors.bg0 },
              TelescopePreviewBorder = { bg = colors.bg0, fg = colors.bg0 },
              TelescopePromptTitle = { bg = colors.purple, fg = colors.bg0 },
              TelescopeResultsTitle = { fg = colors.bg0 },
              TelescopePreviewTitle = { bg = colors.green, fg = colors.bg0 },
              CmpItemKindField = { bg = colors.red, fg = colors.bg0 },

              PMenu = { bg = "none" },
            }
          end,
        }
        require("tokyodark").setup(options)
      '';
    };

}
