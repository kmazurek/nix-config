{ inputs, pkgs, lib, ... }:
{

  # homebrew = {
  #   enable = true;
  #   onActivation = {
  #     autoUpdate = true;
  #     cleanup = "zap";
  #     upgrade = true;
  #   };
  #   brewPrefix = "/opt/homebrew/bin";
  #   caskArgs = {
  #     no_quarantine = true;
  #   };
  #
  #   masApps = {
  #     "hidden-bar" = 1452453066;
  #     "bitwarden" = 1352778147;
  #     "amorphousdiskmark" = 1168254295;
  #     "wireguard" = 1451685025;
  #     "parcel" = 639968404;
  #   };
  #
  #
  #   casks = [
  #     "alacritty"
  #     "amethyst"
  #     "gimp"
  #     "gpg-suite"
  #     "hasicorp-vagrant"
  #     "karabiner-elements"
  #     "raycast"
  #     "signal"
  #     "stats"
  #   ];
  # };

  # system = "aarch64-darwin";

  modules = [
    # collect all the necessary modules
    inputs.home-manager.darwinModules.home-manager
    ./home/darwin
  ];

  environment.systemPackages = with pkgs; [
    bat
    jq
    yq
  ];

}
