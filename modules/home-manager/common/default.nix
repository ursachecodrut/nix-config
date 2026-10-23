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
    ../programs/herdr
    ../programs/nvim
    ../programs/btop
    ../programs/direnv
    ../programs/yazi
    ../scripts
  ];

  catppuccin = {
    enable = true;
    autoEnable = false;
    flavor = "mocha";
    accent = "lavender";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.hostPlatform.isDarwin then
        "/Users/${userConfig.name}"
      else
        "/home/${userConfig.name}";
  };

  home.packages =
    with pkgs;
    [
      tree
      jq
      fd
      dig
      dust
      unzip
      ripgrep
      rclone
      fastfetch
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [
    ]
    ++ lib.optionals (!stdenv.hostPlatform.isDarwin) [
      tesseract
      unzip
    ];
}
