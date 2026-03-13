{
  flake.modules.plugins.navic = {
    plugins.navic = {
      enable = true;
      settings = {
        lsp = {
          auto_attach = true;
          preference = [ "nix" ];
        };
        highlight = false;
        separator = " > ";
        depth_limit = 0;
        depth_limit_indicator = "..";
        safe_output = true;
        lazy_update_context = false;
        click = false;
        icons = {
          File = "󰈙 ";
          Module = " ";
          Namespace = "󰌗 ";
          Package = " ";
          Class = "󰌗 ";
          Method = "󰆧 ";
          Property = " ";
          Field = " ";
          Constructor = " ";
          Enum = "󰕘";
          Interface = "󰕘";
          Function = "󰊕 ";
          Variable = "󰆧 ";
          Constant = "󰏿 ";
          String = "󰀬 ";
          Number = "󰎠 ";
          Boolean = "◩ ";
          Array = "󰅪 ";
          Object = "󰅩 ";
          Key = "󰌋 ";
          Null = "󰟢 ";
          EnumMember = " ";
          Struct = "󰌗 ";
          Event = " ";
          Operator = "󰆕 ";
          TypeParameter = "󰊄 ";
          enabled = true;
        };
      };
    };
  };
}
