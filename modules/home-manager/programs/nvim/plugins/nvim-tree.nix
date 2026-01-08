{
  programs.nixvim = {
    globals = {
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };

    plugins = {
      web-devicons.enable = true;

      nvim-tree = {
        enable = true;

        settings = {
          view = {
            width = 35;
          };
          renderer = {
            indent_markers = {
              enable = true;
            };
            icons = {
              glyphs = {
                folder = {
                  arrow_closed = "";
                  arrow_open = "";
                };
              };
            };
          };
          actions = {
            open_file = {
              window_picker = {
                enable = false;
              };
            };
          };
          filters = {
            custom = [ ".DS_Store" ];
          };
          git = {
            ignore = false;
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ee";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "Toggle file explorer";
      }
      {
        mode = "n";
        key = "<leader>ef";
        action = "<cmd>NvimTreeFindFileToggle<CR>";
        options.desc = "Toggle file explorer on current file";
      }
      {
        mode = "n";
        key = "<leader>ec";
        action = "<cmd>NvimTreeCollapse<CR>";
        options.desc = "Collapse file explorer";
      }
      {
        mode = "n";
        key = "<leader>er";
        action = "<cmd>NvimTreeRefresh<CR>";
        options.desc = "Refresh file explorer";
      }
    ];
  };
}
