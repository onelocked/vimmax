{
  flake.modules.plugins.snacks =
    { lib, ... }:
    let
      inherit (lib.nixvim) listToUnkeyedAttrs mkRaw;
    in
    {
      plugins.snacks = {
        enable = true;
        settings = {
          bigfile.enabled = true;
          scroll.enabled = false;
          quickfile.enabled = true;
          indent.enabled = true;
          words.enabled = true;
          input.enabled = true;
          terminal.enabled = true;
          scratch.enabled = false;
          picker =
            let
              keys = {
                "<c-d>" = (listToUnkeyedAttrs [ "preview_scroll_down" ]) // {
                  mode = "n";
                };
                "<c-u>" = (listToUnkeyedAttrs [ "preview_scroll_up" ]) // {
                  mode = "n";
                };
              };
            in
            {
              enabled = true;
              win = {
                input.keys = keys;
                list.keys = keys;
              };
              layouts = {
                sexy.layout = (
                  listToUnkeyedAttrs [
                    {
                      win = "input";
                      height = 1;
                      border = "single";
                      title = "Find {title} {live} {flags}";
                      title_pos = "center";
                    }
                    (
                      listToUnkeyedAttrs [
                        {
                          win = "list";
                          border = [
                            "🭽"
                            "▔"
                            "🭾"
                            "▕"
                            "🭿"
                            "▁"
                            "🭼"
                            "▏"
                          ];
                        }
                        {
                          win = "preview";
                          border = [
                            "🭽"
                            "▔"
                            "🭾"
                            "▕"
                            "🭿"
                            "▁"
                            "🭼"
                            "▏"
                          ];
                          width = 0.6;
                        }
                      ]
                      // {
                        box = "horizontal";
                      }
                    )
                  ]
                  // {
                    box = "vertical";
                    width = 0.9;
                    height = 0.9;
                    border = "none";
                  }
                );
              };
              sources.explorer = {
                actions.toggle_preview = mkRaw ''
                  function(picker)
                    picker.preview.win:toggle()
                  end
                '';
                layout.layout = (
                  listToUnkeyedAttrs [
                    {
                      win = "input";
                      height = 1;
                      border = "rounded";
                      title = "{title} {live} {flags}";
                      title_pos = "center";
                    }
                    {
                      win = "list";
                      border = "none";
                    }
                  ]
                  // {
                    backdrop = false;
                    width = 40;
                    min_width = 40;
                    height = 0;
                    position = "left";
                    border = "rounded";
                    box = "vertical";
                  }
                );
                on_show = mkRaw ''
                  function(picker)
                    local show = false
                    local gap = 1
                    local min_width, max_width = 20, 100
                    --
                    local rel = picker.layout.root
                    local update = function(win) ---@param win snacks.win
                      win.opts.row = vim.api.nvim_win_get_position(rel.win)[1]
                      win.opts.col = vim.api.nvim_win_get_width(rel.win) + gap
                      win.opts.height = 0.8
                      local border = win:border_size().left + win:border_size().right
                      win.opts.width = math.max(min_width, math.min(max_width, vim.o.columns - border - win.opts.col))
                      win:update()
                    end
                    local preview_win = Snacks.win.new {
                      relative = 'editor',
                      external = false,
                      focusable = false,
                      border = 'rounded',
                      backdrop = false,
                      show = show,
                      bo = {
                        filetype = 'snacks_float_preview',
                        buftype = 'nofile',
                        buflisted = false,
                        swapfile = false,
                        undofile = false,
                      },
                      on_win = function(win)
                        update(win)
                        picker:show_preview()
                      end,
                    }
                    rel:on('WinResized', function()
                      update(preview_win)
                    end)
                    picker.preview.win = preview_win
                    picker.main = preview_win.win
                  end
                '';
                on_close =
                  # lua
                  mkRaw ''
                    function(picker)
                      picker.preview.win:close()
                    end
                  '';
              };
              layout.preset = "sexy";
            };
          image = {
            enabled = true;
            border = "rounded";
            doc.inline = false;
          };
          notifier = {
            enabled = true;
            style = "minimal";
            top_down = false;
          };
        };
      };

      autoCmd = [
        {
          desc = "Pre init Function";
          event = [ "VimEnter" ];
          callback = mkRaw ''
            function()
              _G.dd = function(...)
                Snacks.debug.inspect(...)
              end
              _G.bt = function()
                Snacks.debug.backtrace()
              end
              vim.print = _G.dd

              Snacks.toggle.diagnostics():map("<leader>ud")
              Snacks.toggle.line_number():map("<leader>ul")
              Snacks.toggle.inlay_hints():map("<leader>uh")
              Snacks.toggle.treesitter():map("<leader>uT")
              Snacks.toggle.option("spell",
                { name = "Spelling" }):map("<leader>us")
              Snacks.toggle.option("wrap",
                { name = "Wrap" }):map("<leader>uw")
              Snacks.toggle.option("relativenumber",
                { name = "Relative Number" }):map("<leader>uL")
              Snacks.toggle.option("conceallevel",
                { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
              Snacks.toggle.option("background",
                { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
            end
          '';
        }
      ];
    };
}
