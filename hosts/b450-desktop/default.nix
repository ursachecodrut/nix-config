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

  # The 200M Windows ESP is mounted at /boot/efi; /boot itself lives on the
  # root ext4 filesystem so kernels/initrds are not limited by the ESP size.
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.grub.configurationLimit = 3;

  # modules/nixos/common disables CUPS by default; printing is already
  # enabled on this machine.
  services.printing.enable = lib.mkForce true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.corectrl.enable = true;

  system.stateVersion = "26.05";
}
