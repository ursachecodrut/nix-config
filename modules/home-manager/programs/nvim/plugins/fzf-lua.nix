{
  programs.nixvim = {
    plugins.fzf-lua = {
      enable = true;

      settings = {
        fzf_opts = {
          "--ansi" = "";
          "--info" = "inline";
          "--height" = "100%";
          "--layout" = "reverse";
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
      };
    };
  };
}
