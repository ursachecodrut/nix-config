{ pkgs, ... }:
{
  programs.nixvim = {
    globals = {
      mapleader = " ";
    };
    keymaps = [
      # Remap space as leader key
      {
        mode = "";
        key = "<Space>";
        action = "<Nop>";
        options = { };
      }
      # zz centers your current view (handled in movement below)
      # Better vertical movement
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options = { };
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options = { };
      }
      # General keymaps
      {
        mode = "i";
        key = "jk";
        action = "<ESC>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>nh";
        action = ":nohl<CR>";
        options = { };
      }
      # Increment and decrement numbers
      {
        mode = "n";
        key = "<leader>+";
        action = "<C-a>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>-";
        action = "<C-x>";
        options = { };
      }
      # Splitting
      {
        mode = "n";
        key = "<leader>sv";
        action = "<C-w>v";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<C-w>s";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>se";
        action = "<C-w>=";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>sx";
        action = ":close<CR>";
        options = { };
      }
      # Tabbing
      {
        mode = "n";
        key = "<leader>to";
        action = ":tabnew<CR>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>tx";
        action = ":tabclose<CR>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>tn";
        action = ":tabn<CR>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>tp";
        action = ":tabp<CR>";
        options = { };
      }
      # Fast reload
      {
        mode = "n";
        key = "<leader>w";
        action = ":write<CR>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":quit<CR>";
        options = { };
      }
      {
        mode = "n";
        key = "<leader>fm";
        action.__raw = ''
          function()
            vim.lsp.buf.format { async = true }
          end
        '';
        options = {
          desc = "LSP formatting";
        };
      }
    ];
  };
}
