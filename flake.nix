{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-23.11-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.11";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # nixpkgs-firefox-darwin = {
    #   url = "github:bandithedoge/nixpkgs-firefox-darwin";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    { self
    , nixpkgs
      # , home-manager
    , nix-darwin
      # , nixpkgs-firefox-darwin
    , ...
    }@inputs: {

      darwinConfigurations = {
        juni-mbp = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./machines/darwin/juni-mbp
            ./modules/shared/base.nix
          ];
        };
      };

      nixosConfigurations = {
        malloc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./machines/nixos
            ./modules/shared/base.nix
          ];
        };
      };

    };
}
