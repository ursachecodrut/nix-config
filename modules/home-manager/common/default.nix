{
  userConfig,
  pkgs,
  ...
}:
{
  imports = [
    ../programs/git
    ../programs/zsh
    ../programs/starship
    ../programs/tmux
    ../programs/nvim
    ../programs/firefox
    ../programs/btop
    ../programs/foot
    ../programs/signal
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "${userConfig.name}";
    # homeDirectory =
    #   if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
    homeDirectory = "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    tree
    jq
    fd
    dig
    dust
    unzip
    ripgrep
  ];
}
