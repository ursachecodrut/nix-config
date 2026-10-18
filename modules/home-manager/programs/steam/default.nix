{ pkgs, ... }:

{
  home.packages = with pkgs; [
    steam
  ];

  # Proton-GE, picked per game in Steam's compatibility settings.
  home.file.".steam/root/compatibilitytools.d/${pkgs.proton-ge-bin.name}".source =
    pkgs.proton-ge-bin.steamcompattool;
}
