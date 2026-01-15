{ hmModules, ... }:
{
  imports = [
    "${hmModules}/common"
    "${hmModules}/programs/wezterm"
    ./zsh.nix
  ];

  programs.home-manager.enable = true;

  home.stateVersion = "26.05";
}
