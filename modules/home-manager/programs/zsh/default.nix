{ pkgs, ... }:

{
  home.packages = with pkgs; [
    eza
    bat
    fzf
    zoxide
    starship
    mise
    gettext
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      TERM = "xterm-256color";

      ERL_AFLAGS = "-kernel shell_history enabled";
    };

    shellAliases = {
      # Eza / LS
      ls = "eza";
      ll = "eza --long --icons --time-style='long-iso'";
      la = "ll -a";
      tree = "eza --tree --level=2";
      tree3 = "eza --tree --level=3";
      tree4 = "eza --tree --level=4";
      
      # Neovim
      v = "nvim";
      vim = "nvim";
      vi = "nvim";

      # Git
      g = "git";
      gco = "git checkout";
      gs = "git status";
      gcm = "git commit -m";
      gl = "git log --oneline --decorate";
      gll = "git log --oneline --decorate --graph";
      gpl = "git pull";
      gplr = "git pull --rebase";
      gcl = "git clone";
      ga = "git add .";
      gap = "git add -p";

      # Tools
      cat = "bat";
    };
  };

  catppuccin.bat.enable = true;
  catppuccin.eza.enable = true;

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
