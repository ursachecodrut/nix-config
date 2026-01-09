{ config, pkgs, ... }:

let
  batteryScript = pkgs.writeShellScript "battery-status" ''
    BAT=$(ls /sys/class/power_supply/ | grep BAT | head -n 1)

    if [ -z "$BAT" ]; then exit 0; fi

    STATUS=$(cat /sys/class/power_supply/$BAT/status)
    CAPACITY=$(cat /sys/class/power_supply/$BAT/capacity)

    if [ "$STATUS" = "Charging" ]; then
        ICON=""
    elif [ "$CAPACITY" -ge 90 ]; then
        ICON=""
    elif [ "$CAPACITY" -ge 60 ]; then
        ICON=""
    elif [ "$CAPACITY" -ge 40 ]; then
        ICON=""
    elif [ "$CAPACITY" -ge 20 ]; then
        ICON=""
    else
        ICON="" # Empty
    fi

    echo "<span>$ICON  $CAPACITY%</span>"
  '';
in
{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          path = "${config.wallpaper}";
          blur_passes = 3;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      general = {
        fail_timeout = 1000;
      };

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          capslock_color = -1;
          placeholder_text = "<i><span foreground=\"##e6e9ef\">Password</span></i>";
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
          hide_input = false;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Date
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date '+%A, %d %B')</span>\"";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 15;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -400";
          halign = "center";
          valign = "top";
        }
        # Time
        {
          monitor = "";
          text = "cmd[update:1000] echo \"<span>$(date '+%H:%M')</span>\"";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 120;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -400";
          halign = "center";
          valign = "top";
        }
        # Layout
        {
          monitor = "";
          text = "$LAYOUT";
          color = "rgba(255, 255, 255, 0.9)";
          font_size = 10;
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "0, -175";
          halign = "center";
          valign = "center";
        }
        # Battery
        {
          monitor = "";
          text = "cmd[update:5000] ${batteryScript}";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 18;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, 30";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
