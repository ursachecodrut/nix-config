{ lib, ... }:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ./cat-leaves.png;
    readOnly = true;
    description = "Path to default wallpaper";
  };
}
