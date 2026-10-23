{
  hostname,
  nixosModules,
  userConfig,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware.nix
    "${nixosModules}/common"
    "${nixosModules}/desktop/plasma"
    "${nixosModules}/desktop/niri"
    "${nixosModules}/programs/brave"
    "${nixosModules}/programs/steam"
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

  programs.gamemode = {
    enable = true;
    settings.general.renice = 10;
  };
  users.users.${userConfig.name}.extraGroups = [ "gamemode" ];

  programs.corectrl.enable = true;

  hardware.amdgpu.overdrive.enable = true;

  environment.systemPackages = [ pkgs.cifs-utils ];

  # TrueNAS SMB share. Credentials live outside the Nix store; create with:
  #   sudo sh -c 'printf "username=USER\npassword=PASS\n" > /etc/smb-secrets-nas'
  #   sudo chmod 600 /etc/smb-secrets-nas
  fileSystems."/mnt/nas/media" = {
    device = "//192.168.50.152/media";
    fsType = "cifs";
    options = [
      "credentials=/etc/smb-secrets-nas"
      "uid=1000"
      "gid=100"
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.mount-timeout=10"
      "nofail"
      "_netdev"
    ];
  };

  system.stateVersion = "26.05";
}
