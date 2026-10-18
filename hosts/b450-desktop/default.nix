{
  hostname,
  nixosModules,
  lib,
  ...
}:

{
  imports = [
    ./hardware.nix
    "${nixosModules}/common"
    "${nixosModules}/desktop/plasma"
    "${nixosModules}/programs/brave"
  ];

  networking.hostName = hostname;

  # modules/nixos/common defaults every host to GRUB; this machine was
  # installed with systemd-boot and should keep booting that way.
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.grub.enable = lib.mkForce false;

  # modules/nixos/common disables CUPS by default; printing is already
  # enabled on this machine.
  services.printing.enable = lib.mkForce true;

  system.stateVersion = "26.05";
}
