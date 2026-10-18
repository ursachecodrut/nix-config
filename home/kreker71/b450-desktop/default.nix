{
  hmModules,
  pkgs,
  ...
}:

{
  imports = [
    "${hmModules}/common"
    "${hmModules}/programs/brave"
    "${hmModules}/programs/kitty"
    "${hmModules}/programs/claude-code"
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    kdePackages.kate
  ];

  home.stateVersion = "26.05";
}
