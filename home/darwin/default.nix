{ lib, pkgs, ... }:
let
  username = "kuba";
in
{
  programs.home-manager.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix.settings.trusted-users = [ ${username} ];

  home = {
    username = ${username};
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # users = {
  #   users = {
  #     kuba = {
  #       shell = pkgs.zsh;
  #       uid = 1000;
  #       isNormalUser = true;
  #       group = "kuba";
  #     };
  #   };
  #   groups = {
  #     kuba = {
  #       gid = 1000;
  #     };
  #   };
  # };

  # programs.zsh.enable = true;
}
