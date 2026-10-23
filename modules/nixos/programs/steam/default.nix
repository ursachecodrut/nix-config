{ pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;

    # Proton-GE, picked per game in Steam's compatibility settings.
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
}
