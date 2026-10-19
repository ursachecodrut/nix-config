{
  programs.nixvim = {
    opts = {
      autoread = true;
      completeopt = "menu,menuone,noselect";
      swapfile = false;
      title = true;
      signcolumn = "yes";
      winborder = "rounded";
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      autoindent = true;
      smarttab = true;
      smartindent = true;
      wrap = false;
      foldenable = false;
      ignorecase = true;
      smartcase = true;
      incsearch = true;
      backspace = "indent,eol,start";
      clipboard = "unnamedplus";
      mouse = "a";
      splitright = true;
      splitbelow = true;
      virtualedit = "onemore";
      iskeyword = [
        "@"
        "-"
        "_"
      ]; # default plus "-"
      backupcopy = "yes";
      exrc = true;
      secure = true;
      foldlevelstart = 99;
    };

    diagnostic.settings = {
      update_in_insert = false;
      severity_sort = true;
    };

    autoCmd = [
      {
        event = "FileType";
        pattern = "qf";
        callback.__raw = ''
          function()
            vim.keymap.set("n", "dd", function()
              local list = vim.fn.getqflist()
              local line = vim.fn.line(".")
              table.remove(list, line)
              vim.fn.setqflist(list, "r")
              print("Deleted item at line " .. line)
            end, { buffer = true, desc = "Delete quickfix item" })
          end
        '';
      }
      {
        event = "CursorHold";
        pattern = "*";
        command = "checktime";
      }
    ];
  };
}
