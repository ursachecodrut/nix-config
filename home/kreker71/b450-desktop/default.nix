{
  hmModules,
  pkgs,
  ...
}:

{
  imports = [
    "${hmModules}/common"
    "${hmModules}/misc/wallpaper"
    "${hmModules}/desktop/plasma"
    "${hmModules}/desktop/niri"
    "${hmModules}/programs/noctalia"
    "${hmModules}/programs/brave"
    "${hmModules}/programs/kitty"
    "${hmModules}/programs/claude-code"
    "${hmModules}/programs/signal"
    "${hmModules}/programs/mangohud"
    "${hmModules}/programs/lutris"
    "${hmModules}/programs/obsidian"
    "${hmModules}/programs/obs-studio"
    "${hmModules}/programs/thunderbird"
    "${hmModules}/services/syncthing"
    "${hmModules}/services/kdeconnect"
  ];

  programs.home-manager.enable = true;

  signal.passwordStore = "kwallet6";

  home.packages = with pkgs; [
    kdePackages.kate
    discord
    wl-clipboard
    xclip
    vlc

    # gaming
    heroic
    protonup-qt
    vulkan-tools # vulkaninfo --summary
  ];

  home.stateVersion = "26.05";
}
