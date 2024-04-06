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
  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-darwin
    , nix-darwin
    , home-manager
    , ...
    }@inputs:
    let
      # TODO not sure why we need this?
      inherit (self) outputs;
      linuxPackages = nixpkgs.legacyPackages."x86_64-linux";
      darwinPackages = nixpkgs-darwin.legacyPackages."aarch64-darwin";

      darwinProfiles = import ./profiles/darwin/profiles.nix { inherit inputs outputs; };
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

      # darwinConfigurations = {
      #   juni-mbp = nix-darwin.lib.darwinSystem {
      #     # system = "aarch64-darwin";
      #     specialArgs = { inherit inputs outputs; };
      #     modules = [ ./hosts/darwin/juni-mbp ];
      #   };
      # };

      darwinConfigurations = {
        "juni-mbp" = nix-darwin.lib.darwinSystem darwinProfiles.juni-mbp;
      };

      nixosConfigurations = {
        "ramno" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs outputs; };
          modules = [ ./hosts/nixos/ramno ];
        };
      };

    };
}
