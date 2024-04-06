{ inputs, outputs, ... }:
let
  user-config = rec {
    username = "kuba";
    homeDirectory = "/Users/${username}";
    cacheDirectory = "${homeDirectory}/.cache";
    configDirectory = "${homeDirectory}/.local";
  };
in
{
  juni-mbp = {
    system = "aarch64-darwin";
    modules = [
      # ./hosts/darwin/juni-mbp
      inputs.home-manager.darwinModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.${user-config.username}.imports = [ ../../home/darwin ];
        home-manager.extraSpecialArgs = { inherit user-config; };
      }
    ];
    specialArgs = { inherit inputs outputs; };
  };
}
