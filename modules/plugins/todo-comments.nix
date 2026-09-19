{
  neovim.mods = {
    plugins.todo-comments = {
      enable = true;
      settings = {
        keywords = {
          FIX = {
            alt = [
              "FIXME"
              "BUG"
              "FIXIT"
              "ISSUE"
            ];
            color = "error";
            icon = " ";
          };
          NOTE = {
            alt = [ "INFO" ];
            color = "hint";
            icon = " ";
          };
          TEST = {
            alt = [
              "TESTING"
              "PASSED"
              "FAILED"
            ];
            color = "test";
            icon = "⏲ ";
          };
          TODO = {
            color = "info";
            icon = " ";
          };
          WARN = {
            alt = [
              "WARNING"
              "XXX"
            ];
            color = "warning";
            icon = " ";
          };
        };
      };
      lazyLoad = {
        enable = true;
        settings = {
          event = [
            "BufReadPost"
            "BufNewFile"
          ];
          cmd = [
            "TodoTrouble"
            "TodoTelescope"
            "TodoLocList"
            "TodoQuickFix"
          ];
        };
      };
    };
  };
}
