{ lib, pkgs, ... }:

{
  # Registers a "niri" Wayland session; SDDM (enabled by the plasma module)
  # lists it next to "Plasma (Wayland)" in the session picker.
  programs.niri.enable = true;

  # Both Plasma and niri set a default session; keep Plasma preselected at login.
  services.displayManager.defaultSession = lib.mkForce "plasma";

  environment.systemPackages = with pkgs; [
    playerctl
    grim # screenshots
    slurp
    wl-clipboard
  ];
}
