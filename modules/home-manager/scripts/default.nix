{
  pkgs,
  lib,
  ...
}:
{
  home.file = {
    ".local/bin" = {
      recursive = true;
      source = ./bin;
    };
  };

  # conditional configuration for Darwin systems
  home.sessionPath = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isDarwin [
      "$HOME/.local/bin"
    ])
  ];
}
