{ pkgs, ... }:
let
  theme = name: "include ${pkgs.kitty-themes}/share/kitty-themes/themes/${name}.conf";
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 10;
    };

    settings = {
      # Cursor trail
      cursor_trail = 1;
      cursor_trail_decay = "0.1 0.4";
      cursor_trail_start_threshold = 2;

      # Cursor appearance
      cursor_shape = "block";
      cursor_blink_interval = 0;

      # Window
      window_padding_width = 8;

      # Performance
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";

      # Misc
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      remember_window_size = "no";
    };
  };

  # Kitty switches between these automatically following the system
  # light/dark preference (freedesktop color-scheme portal).
  xdg.configFile = {
    "kitty/dark-theme.auto.conf".text = theme "Catppuccin-Mocha";
    "kitty/light-theme.auto.conf".text = theme "Catppuccin-Latte";
    "kitty/no-preference-theme.auto.conf".text = theme "Catppuccin-Mocha";
  };
}
