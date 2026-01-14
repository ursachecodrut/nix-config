{ darwinModules, ... }:
{
  imports = [
    "${darwinModules}/common"
    ./homebrew.nix
  ];

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 6;
}