{
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  catppuccin.cursors.enable = true;
  home.pointerCursor = {
    enable = true;
    size = 24;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    cursor-theme = "catppuccin-mocha-lavender-cursors";
    cursor-size = 24;
  };
}
