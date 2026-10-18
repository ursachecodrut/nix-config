{
  config,
  lib,
  pkgs,
  ...
}:
let
  navigation = import ./vim-herdr-navigation.nix { inherit pkgs; };
  # stable path so the herdr plugin link survives plugin updates
  navigationLink = "${config.xdg.dataHome}/herdr-plugins/vim-herdr-navigation";
in
{
  programs.herdr = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./config.toml);
  };

  home.packages = [
    pkgs.lazygit
    pkgs.jq
  ];

  home.file."${lib.removePrefix config.home.homeDirectory navigationLink}".source = navigation;

  home.activation.herdrLinkNavigation = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${lib.getExe config.programs.herdr.package} plugin link ${navigationLink} >/dev/null 2>&1 || true
  '';
}
