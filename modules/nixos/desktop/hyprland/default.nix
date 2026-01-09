{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;

  services.blueman.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Enable security services
  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;
  security.pam.services = {
    hyprlock = { };
    gdm.enableGnomeKeyring = true;
  };

  # Update DBus environment for Wayland sessions
  # This is needed for some applications to work correctly under Wayland (e.g., clipboard managers, notification daemons)
  systemd.user.services.dbus-update-environment = {
    description = "Update DBus activation environment";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP";
      Type = "oneshot";
    };
  };

  environment.systemPackages = with pkgs; [
    file-roller
    gnome-calculator
    gnome-text-editor
    loupe # image viewer
    seahorse # gnome keyring manager
    nautilus # file manager
    totem # video player

    brightnessctl
    grim
    grimblast
    hypridle
    hyprlock
    hyprpaper
    hyprpicker
    # libnotify
    networkmanagerapplet
    # pamixer
    pavucontrol
    slurp
    wf-recorder
    wlr-randr
    wlsunset
  ];
}
