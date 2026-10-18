{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.catppuccin-kde.override {
      flavour = [ "macchiato" ];
      accents = [ "lavender" ];
      winDecStyles = [ "modern" ];
    })
  ];

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "Catppuccin-Macchiato-Lavender";
      colorScheme = "CatppuccinMacchiatoLavender";
      iconTheme = "breeze-dark";
      cursor.theme = "breeze_cursors";
      wallpaper = config.wallpaper;
    };

    kscreenlocker.appearance.wallpaper = config.wallpaper;

    configFile."kwinrc"."org.kde.kdecoration2" = {
      library = "org.kde.kwin.aurorae";
      theme = "__aurorae__svg__CatppuccinMacchiato-Modern";
    };

    kwin.virtualDesktops = {
      number = 4;
      rows = 1;
    };

    shortcuts.kwin = {
      "Window Close" = [
        "Alt+F4"
        "Meta+Q"
      ];
      "Switch to Desktop 1" = "Meta+1";
      "Switch to Desktop 2" = "Meta+2";
      "Switch to Desktop 3" = "Meta+3";
      "Switch to Desktop 4" = "Meta+4";
    };

    shortcuts.org_kde_powerdevil.powerProfile = "Meta+Shift+B";

    hotkeys.commands.launch-browser = {
      name = "Launch browser";
      key = "Meta+B";
      command = "brave";
    };

    hotkeys.commands.launch-terminal = {
      name = "Launch terminal";
      key = "Meta+Return";
      command = "kitty";
    };

    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
    };
  };
}
