{ lib, ... }:
{
  options.wallpaper = lib.mkOption {
    type = lib.types.path;
    default = ./yosemite.png;
    readOnly = true;
    description = "Path to default wallpaper";
  };
}
