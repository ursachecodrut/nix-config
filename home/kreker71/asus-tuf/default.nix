{
  hmModules,
  ...
}:

{
  imports = [
    "${hmModules}/common"
    "${hmModules}/desktop/hyprland"
    "${hmModules}/programs/foot"
    "${hmModules}/programs/firefox"
    "${hmModules}/programs/signal"
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
