{
  programs.nixvim = {
    plugins.marks = {
      enable = true;
      settings = {
        cyclic = true;
        mappings = {
          delete = "md";
          delete_buf = "mc";
          delete_line = "mD";
          next = "mn";
          prev = "mp";
          set = "m";
          toggle = "mm";
        };
        refreshInterval = 150;
      };
    };
  };
}
