{ hmModules, ... }:
{
  imports = [
    "${hmModules}/common"
    "${hmModules}/programs/wezterm"
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
