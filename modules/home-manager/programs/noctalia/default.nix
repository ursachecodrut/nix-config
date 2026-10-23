{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  darkWallpaper = "yosemite.png";
  lightWallpaper = "mountain_light.png";

  wallpaperSrc = ../../misc/wallpaper;
  wallpaperFiles = lib.filterAttrs (
    name: type: type == "regular" && (lib.hasSuffix ".png" name || lib.hasSuffix ".jpg" name)
  ) (builtins.readDir wallpaperSrc);
  wallpaperDir = "${config.home.homeDirectory}/.local/share/noctalia-wallpapers";

  swapWallpaper = pkgs.writeShellScript "noctalia-swap-wallpaper" ''
    state="''${XDG_STATE_HOME:-$HOME/.local/state}/noctalia/last-wallpaper-mode"
    [ "$(cat "$state" 2>/dev/null)" = "$1" ] && exit 0
    echo "$1" > "$state"
    case "$1" in
      light) wall="${wallpaperDir}/${lightWallpaper}" ;;
      *) wall="${wallpaperDir}/${darkWallpaper}" ;;
    esac
    exec ${lib.getExe config.programs.noctalia.package} msg wallpaper-set "$wall"
  '';
in
{
  imports = [ inputs.noctalia.homeModules.default ];

  home.file =
    lib.mapAttrs' (
      name: _:
      lib.nameValuePair ".local/share/noctalia-wallpapers/${name}" { source = wallpaperSrc + "/${name}"; }
    ) wallpaperFiles
    // {
      ".config/noctalia/templates/theme-mode.txt".text = "{{ mode }}\n";
    };

  # Set for the whole systemd user session (not just niri's environment block)
  # so apps started from the noctalia launcher get it too. Plasma's platform
  # theme reads kdeglobals, which noctalia's kcolorscheme template writes.
  systemd.user.sessionVariables.QT_QPA_PLATFORMTHEME = "kde";

  home.packages = with pkgs; [
    bitwarden-cli
    wtype
  ];

  catppuccin.btop.enable = lib.mkForce false;
  programs.btop.settings.color_theme = "noctalia";

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      shell = {
        font_family = "JetBrainsMono Nerd Font";
        time_format = "{:%H:%M}";
        date_format = "%A, %d %B";
        telemetry_enabled = false;
        polkit_agent = true;

        screenshot = {
          directory = "~/Pictures/Screenshots";
          save_to_file = true;
          copy_to_clipboard = true;
          freeze_screen = true;
        };

        launcher.show_app_actions = true;
      };

      plugins = {
        enabled = [
          "noctalia/screen_recorder"
          "noctalia/bitwarden"
          "noctalia/timer"
          "noctalia/world_clock"
        ];
        auto_update = "none";
        source = [
          {
            name = "nix";
            kind = "path";
            location = "${inputs.noctalia-plugins}";
            enabled = true;
          }
          {
            name = "official";
            kind = "git";
            location = "https://github.com/noctalia-dev/official-plugins";
            enabled = false;
          }
        ];
      };

      plugin_settings."noctalia/screen_recorder" = {
        hide_inactive = true;
        glyph_recording = "video-filled";
      };

      plugin_settings."noctalia/bitwarden" = {
        vault_timeout = "30";
        clear_clipboard_seconds = 30;
      };

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";

        templates = {
          builtin_ids = [
            "kcolorscheme" # Dolphin and other KDE/Qt apps (merged into kdeglobals)
            "gtk3"
            "gtk4"
            "niri" # ~/.config/niri/noctalia.kdl, included by niri's config.kdl
            "btop" # ~/.config/btop/themes/noctalia.theme
          ];

          user.theme_mode_wallpaper = {
            input_path = "templates/theme-mode.txt";
            output_path = "~/.local/state/noctalia/theme-mode.txt";
            post_hook = "${swapWallpaper} {{ mode }}";
          };
        };
      };

      calendar = {
        enabled = true;
        refresh_minutes = 15;
        dedupe_events = true; # same event in several calendars shows once
        event_date_format = "%A %e %B";
        event_time_format = "%H:%M";

        reminders = {
          enabled = true;
          use_event_reminders = true;
          default_lead_minutes = 10;
          all_day_digest_time = "09:00";
        };
      };

      control_center.calendar = {
        show_events_card = true;
        show_week_numbers = true;
      };

      weather = {
        enabled = true;
        unit = "celsius";
        refresh_minutes = 30;
      };

      nightlight = {
        enabled = true;
        temperature_day = 6500;
        temperature_night = 4000;
      };

      idle.behavior = {
        lock = {
          enabled = true;
          timeout = 600;
          action = "lock";
        };
        screen-off = {
          enabled = true;
          timeout = 660;
          action = "screen_off";
        };
      };

      location = {
        auto_locate = false;
        address = "Bucharest, Romania";
      };

      wallpaper = {
        default.path = "${wallpaperDir}/${darkWallpaper}";
        directory = wallpaperDir;
      };

      bar.main = {
        position = "top";
        thickness = 32;
        font_family = "JetBrainsMono NF";
        background_opacity = 0.9;
        compositor_blur = true;
        radius = 8; # matches niri's window corner radius
        margin_ends = 6; # matches niri's gaps
        margin_edge = 6;
        padding = 10;
        widget_spacing = 6;
        shadow = false;
        capsule = true;
        capsule_fill = "surface_variant";
        capsule_opacity = 0.6;

        start = [
          "launcher"
          "workspaces"
          "active_window"
        ];
        center = [
          "clock"
          "weather"
        ];
        end = [
          "media"
          "noctalia/timer:bar"
          "recorder"
          "tray"
          "screenshot"
          "cpu"
          "ram"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "control-center"
          "session"
        ];
      };

      widget = {
        workspaces = {
          style = "regular";
          hide_when_empty = false;
        };

        active_window = {
          max_length = 300;
          title_scroll = "on_hover";
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip_format = "{:%A, %d %B %Y}";
        };

        cpu = {
          type = "sysmon";
          stat = "cpu_usage";
          visualization = "none";
          label_min_width = 32.0;
        };

        ram = {
          type = "sysmon";
          stat = "ram_pct";
          visualization = "none";
          label_min_width = 32.0;
        };

        notifications.hide_when_no_unread = false;

        # Only visible while recording (hide_inactive below); click to stop.
        recorder.type = "noctalia/screen_recorder:recorder";
      };
    };
  };
}
