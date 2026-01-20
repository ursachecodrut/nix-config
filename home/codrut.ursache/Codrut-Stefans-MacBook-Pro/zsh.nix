{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mise
    gettext         
    usage            # for mise autocomplete
    kubernetes-helm
    kubectl
    kubectx
    claude-code
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
