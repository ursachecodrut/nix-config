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

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    elephant.url = "github:abenz1267/elephant";
    walker = {
      url = "github:abenz1267/walker";
      inputs.elephant.follows = "elephant";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      catppuccin,
      darwin,
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

        "codrut.ursache" = {
          name = "codrut.ursache";
          fullName = "Codrut Stefan Ursache";
          email = "ursache.codrut71@gmail.com";
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

      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        hostname: username:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            darwinModules = "${self}/modules/darwin";
          };
          modules = [ ./hosts/${hostname} ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration =
        system: username: hostname:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs { inherit system; };
          extraSpecialArgs = {
            inherit inputs outputs hostname;
            userConfig = users.${username};
            hmModules = "${self}/modules/home-manager";
          };
          modules = [
            catppuccin.homeModules.catppuccin
            inputs.plasma-manager.homeModules.plasma-manager
            ./home/${username}/${hostname}
          ];
        };

      forAllSystems = nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-darwin"
      ];

      treefmtEval = forAllSystems (
        system:
        inputs.treefmt-nix.lib.evalModule nixpkgs.legacyPackages.${system} {
          projectRootFile = "flake.nix";
          programs = {
            nixfmt.enable = true;
            statix.enable = true;
            deadnix.enable = true;
          };
          settings.global.excludes = [
            "*.png"
            "*.jpg"
            "flake.lock"
          ];
        }
      );
    in
    {
      formatter = forAllSystems (system: treefmtEval.${system}.config.build.wrapper);

      checks = forAllSystems (system: {
        formatting = treefmtEval.${system}.config.build.check self;
      });

      nixosConfigurations = {
        asus-tuf = mkNixosConfiguration "asus-tuf" "kreker71";
        b450-desktop = mkNixosConfiguration "b450-desktop" "kreker71";
      };

      darwinConfigurations = {
        "Codrut-Stefans-MacBook-Pro" = mkDarwinConfiguration "Codrut-Stefans-MacBook-Pro" "codrut.ursache";
      };

      homeConfigurations = {
        "kreker71@asus-tuf" = mkHomeConfiguration "x86_64-linux" "kreker71" "asus-tuf";
        "kreker71@b450-desktop" = mkHomeConfiguration "x86_64-linux" "kreker71" "b450-desktop";
        "codrut.ursache@Codrut-Stefans-MacBook-Pro" =
          mkHomeConfiguration "aarch64-darwin" "codrut.ursache"
            "Codrut-Stefans-MacBook-Pro";
      };
    };
}
