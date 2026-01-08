{
  hmModules,
  ...
}:

{
  imports = [
    "${hmModules}/common"
    "${hmModules}/desktop/hyprland"
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "25.11";
}
