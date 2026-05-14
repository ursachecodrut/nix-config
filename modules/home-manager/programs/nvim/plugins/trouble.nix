{ ... }:

{
  programs.nixvim = {
    plugins.trouble = {
      enable = true;

      settings = {
        auto_close = false;
        auto_preview = true;
        focus = true;
        follow = true;
        indent_guides = true;
        multiline = true;
        restore = true;
        warn_no_results = true;

        modes = {
          symbols = {
            desc = "document symbols";
            mode = "lsp_document_symbols";
            focus = false;
            win = {
              position = "right";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options = {
          desc = "Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options = {
          desc = "Buffer Diagnostics (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xs";
        action = "<cmd>Trouble symbols toggle focus=false<cr>";
        options = {
          desc = "Symbols (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xl";
        action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
        options = {
          desc = "LSP Definitions / references / ... (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options = {
          desc = "Location List (Trouble)";
        };
      }
      {
        mode = "n";
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options = {
          desc = "Quickfix List (Trouble)";
        };
      }
    ];
  };
}
