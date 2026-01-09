{
  description = "Nix configuration for my systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      inherit (self) outputs;

      users = {
        kreker71 = {
          name = "kreker71";
          fullName = "Codrut Ursache";
          email = "ursache.codrut71@gmail.com";
          # avatar = ./files/avatar/face;
        };
      };

      # Function for NixOS system configuration
      mkNixosConfiguration =
        hostname: username:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            nixosModules = "${self}/modules/nixos";
          };
          modules = [
            catppuccin.nixosModules.catppuccin
            ./hosts/${hostname}
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs;
            userConfig = users.${username};
            hmModules = "${self}/modules/home-manager";
          };
          modules = [
            catppuccin.homeModules.catppuccin
            ./home/${username}/${hostname}
          ];
        };
    in
    {
      nixosConfigurations = {
        asus-tuf = mkNixosConfiguration "asus-tuf" "kreker71";
      };

      homeConfigurations = {
        "kreker71@asus-tuf" = mkHomeConfiguration "x86_64-linux" "kreker71" "asus-tuf";
      };

    };
}
