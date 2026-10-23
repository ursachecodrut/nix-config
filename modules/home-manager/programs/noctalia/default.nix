{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [ inputs.noctalia.homeModules.default ];

  # Runs only inside niri: bound to niri.service rather than
  # graphical-session.target, which Plasma also activates.
  systemd.user.services.noctalia = {
    Unit = {
      PartOf = lib.mkForce [ "niri.service" ];
      After = lib.mkForce [ "niri.service" ];
    };
    Install.WantedBy = lib.mkForce [ "niri.service" ];
  };

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
      };

      plugins = {
        enabled = [ "noctalia/screen_recorder" ];
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

      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };

      wallpaper.default.path = "${config.wallpaper}";

      bar.main = {
        position = "top";
        thickness = 32;
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
        center = [ "clock" ];
        end = [
          "media"
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
