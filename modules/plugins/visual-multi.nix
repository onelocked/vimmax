{
  flake.modules.plugins.visual-multi = {
    plugins = {
      visual-multi = {
        enable = true;
        settings = {
          mouse_mappings = 0;
          show_warnings = 1;
          silent_exit = 0;
          set_statusline = 1;
          single_mode_maps = 0;
          quit_after_leaving_insert_mode = 1;
          recursive_operations_at_cursors = 1;
          disable_syntax_in_imode = 1;
          highlight_matches = "";
        };
      };
    };
  };
}
