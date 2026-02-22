{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  flake = {
    options = {
      mkKey = mkOption {
        type = types.attrsOf types.unspecified;
        description = "Helper functions for creating keymaps and which-key objects";
        default = rec {
          mkKeymap = mode: key: action: desc: {
            inherit mode key action;
            options = { inherit desc; silent = true; noremap = true; };
          };
          mkKeymap' = mode: key: action: mkKeymap mode key action null;
          mkKeymapWithOpts = mode: key: action: desc: opts: (mkKeymap mode key action desc) // { options = opts; };
          lazyKey = key: action: desc: { __unkeyed-1 = key; __unkeyed-2 = action; inherit desc; };
          wKeyObj = list:
            let len = builtins.length list;
            in {
              __unkeyed = builtins.elemAt list 0;
              icon = if len > 1 then builtins.elemAt list 1 else "";
              group = if len > 2 then builtins.elemAt list 2 else "";
            } // lib.optionalAttrs (len > 3) { hidden = builtins.elemAt list 3; };
        };
      };

      wKeyList = mkOption {
        type = types.listOf types.attrs;
        description = "List of which-key mappings for UI display";
      };

      onevix = {
        leader = mkOption {
          description = "The leader key for nvim";
          type = types.str;
          default = " ";
        };
      };
    };
  };
}
