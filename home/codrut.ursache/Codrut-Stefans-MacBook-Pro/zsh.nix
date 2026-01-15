{ pkgs, ... }:

{
  home.packages = with pkgs; [
    mise
    gettext
  ];

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
}
