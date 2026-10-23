{
  programs.television.enable = true;

  programs.nix-search-tv = {
    enable = true;
    enableTelevisionIntegration = true;
  };

  programs.zsh.shellAliases.nix-tv = "tv nix-search-tv";
}
