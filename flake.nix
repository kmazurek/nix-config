{
  description = "Kuba's nix config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-darwin
    , nix-darwin
    , home-manager
    , deploy-rs
    , ...
    }@inputs:
    let
      # TODO not sure why we need this?
      inherit (self) outputs;
      linuxPackages = nixpkgs.legacyPackages."x86_64-linux";
      darwinPackages = nixpkgs-darwin.legacyPackages."aarch64-darwin";

      user-config = rec {
        username = "kuba";
        email = "zakaprov@gmail.com";
        # TODO this is currently not compatible with darwin directory structure
        homeDirectory = "/home/${username}";
        cacheDirectory = "${homeDirectory}/.cache";
        configDirectory = "${homeDirectory}/.local";
      };
    in
    {
      # Defines available packages for each architecture+OS
      # TODO have a smarter way of doing this once we need more than two platforms
      packages = {
        x86_64-linux = import ./pkgs linuxPackages;
        aarch64-darwin = import ./pkgs darwinPackages;
      };

      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = {
        x86_64-linux = linuxPackages.nixpkgs-fmt;
        aarch64-darwin = darwinPackages.nixpkgs-fmt;
      };

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs; };

      darwinConfigurations = {
        "juni-mbp" = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/darwin/juni-mbp

            inputs.home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user-config.username}.imports = [ ./home/darwin ];
              home-manager.extraSpecialArgs = { inherit user-config; };
            }
          ];
        };
      };

      nixosConfigurations = {
        "ramno" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixos/ramno ];
        };

        "duch" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs user-config; };
          modules = [
            ./users/kuba
            ./users/root

            ./modules/common
            ./modules/nixos/server

            ./hosts/nixos/duch
          ];
        };
      };

      deploy.nodes = {
        duch = {
          hostname = "192.168.1.176";
          profiles.system = {
            sshUser = user-config.username;
            user = "root";
            sshOpts = [ "-p" "69" ];
            remoteBuild = true;
            path = deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.duch;
          };
        };
      };

      # This is highly advised, and will prevent many possible mistakes
      checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) deploy-rs.lib;
    };
}
