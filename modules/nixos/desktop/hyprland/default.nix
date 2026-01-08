{ pkgs, ... }:
{
  services.displayManager.gdm.enable = true;

  # Call dbus-update-activation-environment on login
  # services.xserver.updateDbusEnvironment = true;

  # Enable Bluetooth support
  services.blueman.enable = true;

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # # Enable security services
  # services.gnome.gnome-keyring.enable = true;
  # security.polkit.enable = true;
  # security.pam.services = {
  #   hyprlock = { };
  #   gdm.enableGnomeKeyring = true;
  # };

  # List of Hyprland specific packages
  environment.systemPackages = with pkgs; [
    file-roller
    gnome-calculator
    gnome-text-editor
    loupe # image viewer
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
