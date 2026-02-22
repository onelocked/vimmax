{
  flake.modules.plugins.todo-comments = {

    plugins.todo-comments = {
      enable = true;
      settings = {
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
          alt = [
            "INFO"
          ];
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

  };
}
