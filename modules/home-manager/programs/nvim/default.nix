{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./options.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs = {
      source = inputs.nixpkgs;
      config = {
        allowUnfree = true;
      };
    };
  };
}
