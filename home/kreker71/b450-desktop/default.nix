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
    "${hmModules}/programs/brave"
    "${hmModules}/programs/kitty"
    "${hmModules}/programs/claude-code"
    "${hmModules}/programs/signal"
    "${hmModules}/programs/steam"
    "${hmModules}/programs/mangohud"
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
    discord
    wl-clipboard
    xclip

    # gaming
    gamemode # Steam launch option: gamemoderun %command%
    lutris
    heroic
    protonup-qt
    vulkan-tools # vulkaninfo --summary
  ];

  home.stateVersion = "26.05";
}
