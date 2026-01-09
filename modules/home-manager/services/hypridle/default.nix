{
  wayland.windowManager.hyprland.systemd.enable = false;
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 150;
          on-timeout = "brightnessctl -s -d amdgpu_bl0 set 10%";
          on-resume = "brightnessctl -r -d amdgpu_bl0";
        }
        {
          timeout = 150;
          on-timeout = "brightnessctl -sd *::kbd_backlight set 0";
          on-resume = "brightnessctl -rd *::kbd_backlight";
        }
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 900;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
