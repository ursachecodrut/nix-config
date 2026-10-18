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
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
  ];

  home.stateVersion = "26.05";
}
