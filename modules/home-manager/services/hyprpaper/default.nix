{ config, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false;

      preload = [
        "${config.wallpaper}"
      ];

      wallpaper = [
        ",${config.wallpaper}"
      ];
    };
  };
}
