{
  flake.modules.plugins.conform =
    { pkgs, lib, ... }:
    {
      plugins = {
        conform-nvim.settings = {
          formatters_by_ft = {
            xml = [ "xmllint" ];
            yaml = [ "yamlfix" ];
            json = [ "fixjson" ];
          };
          formatters = {
            xmllint.command = lib.getExe' pkgs.libxml2 "xmllint";
            fixjson.command = lib.getExe pkgs.fixjson;
            yamlfix.command = lib.getExe pkgs.yamlfix;
          };
        };
      };
    };
}
