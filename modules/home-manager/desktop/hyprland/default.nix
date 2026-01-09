{
  config,
  hmModules,
  ...
}:
{
  imports = [
    "${hmModules}/misc/gtk"
    "${hmModules}/programs/waybar"
    # "${hmModules}/programs/walker"
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

    "hypr/hypridle.conf".text = ''
      general {
        lock_cmd = pidof hyprlock || $HOME/.local/bin/dynamic-hyprlock
        before_sleep_cmd = loginctl lock-session
        after_sleep_cmd = hyprctl dispatch dpms on
      }
    '';

    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
        max_fps = 60
      }
    '';
  };
}
