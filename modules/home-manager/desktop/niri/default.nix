{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
    ./noctalia.nix
  ];

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
