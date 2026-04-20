{
  flake.modules.plugins.windsurf =
    { pkgs, ... }:
    {
      extraPlugins = [ pkgs.vimPlugins.windsurf-nvim ];
      extraConfigLua = ''
        require("codeium").setup({
          enable_cmp_source = false,
          virtual_text = {
            enabled = true,
          }
        })
      '';
    };
}
