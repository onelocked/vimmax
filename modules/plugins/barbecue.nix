{
  flake.modules.plugins.barbecue = {
    plugins.barbecue = {
      enable = true;
      settings = {
        context_follow_icon_color = true;
        show_dirname = false;
      };
    };
  };
}
