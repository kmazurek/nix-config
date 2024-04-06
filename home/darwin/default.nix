{ lib, pkgs, user-config, ... }: {
  programs.home-manager.enable = true;

  nix.settings.trusted-users = [ user-config.username ];

  home = {
    username = user-config.username;
    homeDirectory = lib.mkForce user-config.homeDirectory;
    stateVersion = "23.11";
    packages = with pkgs; [
      httpie
    ];
  };

  # users = {
  #   users = {
  #     ${user-config.username} = {
  #       shell = pkgs.zsh;
  #       uid = 1000;
  #       isNormalUser = true;
  #       group = user-config.username;
  #     };
  #   };
  #   groups = {
  #     ${user-config.username} = {
  #       gid = 1000;
  #     };
  #   };
  # };
  #
  programs.zsh.enable = true;
}
