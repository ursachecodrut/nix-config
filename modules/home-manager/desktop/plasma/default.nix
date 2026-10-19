{
  config,
  lib,
  pkgs,
  ...
}:

let
  wallpaperPath = "${config.home.homeDirectory}/.local/share/wallpapers/default-wallpaper.png";
in
{
  # Plasma 6.8 rejects wallpapers living directly in /nix/store ("unknown
  # wallpaper provider type") and falls back to the default, so expose the
  # image under a regular path in the home directory and point KDE at that.
  home.file.".local/share/wallpapers/default-wallpaper.png".source = config.wallpaper;

  # KDE caches the app list (sycoca) and does not notice new .desktop files
  # that appear via the nix profile symlink, so rebuild it after each switch.
  home.activation.rebuildKdeAppCache = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run ${pkgs.kdePackages.kservice}/bin/kbuildsycoca6 --noincremental || true
  '';

  programs.plasma = {
    enable = true;

    workspace = {
      iconTheme = "breeze-dark";
      cursor.theme = "breeze_cursors";
      wallpaper = wallpaperPath;
    };

    kscreenlocker.appearance.wallpaper = wallpaperPath;

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
