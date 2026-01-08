{
  programs.nixvim = {
    plugins.oil = {
      enable = true;

      settings = {
        columns = [
          "icon"
          "permissions"
          "size"
        ];
        
        view_options = {
          show_hidden = true;
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "-";
        action = "<CMD>Oil<CR>";
        options = {
          desc = "Open parent directory";
        };
      }
    ];
  };
}
