{ pkgs, ... }:

{
  programs.lutris = {
    enable = true;
    extraPackages = with pkgs; [
      umu-launcher
      gamemode
      gamescope
      mangohud
    ];
    protonPackages = [ pkgs.proton-ge-bin ];
  };
}
