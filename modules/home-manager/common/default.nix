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
    ../programs/btop
    ../programs/direnv
    ../scripts
  ];

  catppuccin = {
    enable = true;
    autoEnable = false;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  home.packages = with pkgs; [
    tree
    jq
    fd
    dig
    dust
    unzip
    ripgrep
    rclone
    ] ++
    lib.optionals stdenv.hostPlatform.isDarwin [
    ]
    ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
      tesseract
      unzip
    ];
}
