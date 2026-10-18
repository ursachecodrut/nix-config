let
  exclude = [
    # version control
    ".git"
    # elixir
    "_build"
    "deps"
    ".elixir_ls"
    # frontend / js
    "node_modules"
    "dist"
    "build"
    ".next"
    ".nuxt"
    "coverage"
    # misc
    ".cache"
  ];
  fdExcludes = builtins.concatStringsSep " " (map (d: "--exclude ${d}") exclude);
  rgExcludes = builtins.concatStringsSep " " (map (d: "--glob '!${d}'") exclude);

  copyPath = full: {
    __raw = ''
      function(selected)
        local path = require("fzf-lua").path.entry_to_file(selected[1]).path
        ${if full then ''path = vim.fn.fnamemodify(path, ":p")'' else ""}
        vim.fn.setreg("+", path)
        vim.notify("Copied: " .. path)
      end
    '';
  };

  key = action: desc: {
    inherit action;
    options.desc = desc;
  };
in
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
          "--ansi" = true;
          "--info" = "inline";
          "--height" = "100%";
          "--layout" = "reverse";
        };
        files = {
          fd_opts = "--color=never --type f --hidden --follow ${fdExcludes}";
          actions = {
            "ctrl-y" = copyPath false;
            "ctrl-e" = copyPath true;
          };
        };
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 ${rgExcludes} -e";
        };
      };

      keymaps = {
        "<leader>ff" = key "files" "Fzf Files";
        "<leader>fg" = key "live_grep" "Fzf Live Grep";
        "<leader>fw" = key "grep_cword" "Fzf Grep Word Under Cursor";
        "<leader>fW" = key "grep_cWORD" "Fzf Grep WORD Under Cursor";
        "<leader>fb" = key "buffers" "Fzf Buffers";
        "<leader>fh" = key "help_tags" "Fzf Help Tags";
        "<leader>fd" = key "diagnostics_document" "Fzf Diagnostics";
        "<leader>fr" = key "lsp_references" "Fzf LSP References";
        "<leader>fs" = key "lsp_document_symbols" "Fzf Document Symbols";
        "<leader>fS" = key "lsp_workspace_symbols" "Fzf Workspace Symbols";
        "<leader>fm" = key "marks" "Fzf Marks";
        "<leader>fG" = key "grep_last" "Fzf Grep Last";
        "<leader>f/" = key "search_history" "Fzf Search History";
        "<leader>f:" = key "command_history" "Fzf Command History";
        "<leader>f\"" = key "registers" "Fzf Registers";
        "<leader>gs" = key "git_status" "Fzf Git Status (Stage files with Tab)";
        "<leader>gc" = key "git_commits" "Fzf Git Commits (Checkout on Enter)";
        "<leader>gb" = key "git_branches" "Fzf Git Branches";
        "<leader>gt" = key "git_stash" "Fzf Git Stash";
      };
    };
  };
}
