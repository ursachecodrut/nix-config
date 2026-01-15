{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mise
    gettext         
    usage            # for mise autocomplete
    kubectl
    kubectx
  ];

  programs.zsh = {
    enable = true;
    initContent = ''
      eval "$(gt completion)"
    '';
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
}
