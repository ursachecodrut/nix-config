{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;

      settings = {
        winopts = {
          height = 0.85;
          width = 0.80;
          preview = {
            layout = "vertical"; 
            vertical = "down:50%";
          };
        };
        fzf_opts = {
          "--ansi" = "";
          "--info" = "inline";
          "--height" = "100%";
          "--layout" = "reverse";
        };
        actions = {
          diagnostics = {
            "ctrl-y" = ''
              function(selected)
                -- selected[1] usually contains the text line in fzf-lua
                local msg = selected[1]
                vim.fn.setreg('+', msg)
                print("Copied to clipboard!")
              end
            '';
          };
        };
      };

      keymaps = {
        "<leader>ff" = {
          action = "files";
          options = {
            desc = "Fzf Files";
          };
        };
        "<leader>fg" = {
          action = "live_grep";
          options = {
            desc = "Fzf Live Grep";
          };
        };
        "<leader>fw" = {
          action = "grep_cword";
          options = {
            desc = "Fzf Grep Word Under Cursor";
          };
        };
        "<leader>fW" = {
          action = "grep_cWORD";
          options = {
            desc = "Fzf Grep Word Under Cursor";
          };
        };
        "<leader>fb" = {
          action = "buffers";
          options = {
            desc = "Fzf Buffers";
          };
        };
        "<leader>fh" = {
          action = "help_tags";
          options = {
            desc = "Fzf Help Tags";
          };
        };
        "<leader>fd" = {
          action = "diagnostics_document";
          options = {
            desc = "Fzf Diagnostics";
          };
        };
        "<leader>fr" = {
          action = "lsp_references";
          options = {
            desc = "Fzf LSP References";
          };
        };
        "<leader>gs" = {
          action = "git_status";
          options.desc = "Fzf Git Status (Stage files with Tab)";
        };
        "<leader>gc" = {
          action = "git_commits";
          options.desc = "Fzf Git Commits (Checkout on Enter)";
        };
        "<leader>gb" = {
          action = "git_branches";
          options.desc = "Fzf Git Branches";
        };
        "<leader>gt" = {
          action = "git_stash";
          options.desc = "Fzf Git Stash";
        };

      };
    };
  };
}
