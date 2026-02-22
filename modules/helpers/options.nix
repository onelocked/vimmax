{
  flake.modules.plugins.options =
    { lib, ... }:
    with lib;
    {
      options = {
        wKeyList = mkOption {
          type = types.listOf types.attrs;
          description = "List of which-key mappings for UI display";
        };
      };
    };
}
