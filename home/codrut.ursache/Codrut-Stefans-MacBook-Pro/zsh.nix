{ pkgs, userConfig, ... }:

{
  home.packages = with pkgs; [
    mise
    gettext
    usage # for mise autocomplete
    clickhouse
    kubernetes-helm
    kubectl
    kubectx
    claude-code
  ];

  programs.git = {
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    settings = {
      gpg = {
        format = "ssh";
        ssh = {
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };
      commit = {
        gpgsign = true;
      };
      tag = {
        gpgsign = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      claude-work = "CLAUDE_CONFIG_DIR=\"$HOME/.claude-work\" claude";
    };
    initContent = ''
      eval "$(gt completion)"
    '';
  };

  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
}
