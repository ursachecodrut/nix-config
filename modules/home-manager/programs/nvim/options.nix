{...}:

{
  programs.nixvim = {
    opts = {
      completeopt = "menu,menuone,noselect";
      swapfile = false;
      title = true;
      background = "dark";
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
      iskeyword = [ "@" "-" "_" ]; # default plus "-"
      backupcopy = "yes";
    };
  };
}
