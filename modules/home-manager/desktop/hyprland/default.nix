{
  config,
  hmModules,
  ...
}:
{
  imports = [
    "${hmModules}/services/hyprpaper"
    "${hmModules}/services/hypridle"
    "${hmModules}/misc/wallpaper"
    "${hmModules}/misc/gtk"
    "${hmModules}/programs/waybar"
    "${hmModules}/programs/hyprlock"
    "${hmModules}/programs/walker"
  ];

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = config.gtk.cursorTheme.package;
    name = config.gtk.cursorTheme.name;
    size = 24;
  };

  xdg.configFile = {
    "hypr/hyprland.conf" = {
      source = ./hyprland.conf;
    };

    "hypr/hyprpaper.conf".text = ''
      splash = false
      preload = ${config.wallpaper}
      wallpaper = ,${config.wallpaper}
    '';

    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
        max_fps = 60
      }
    '';
  };
}
