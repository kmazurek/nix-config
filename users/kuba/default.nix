{ lib, pkgs, ... }: {

  nix.settings.trusted-users = [ "kuba" ];

  programs.home-manager.enable = true;
  home = {
    username = "kuba";
    homeDirectory = "/home/kuba";
    stateVersion = "23.05";
  };

  programs.git = {
    enable = true;
    userName = "Kuba Mazurek";
    userEmail = "zakaprov@gmail.com";
  };

  users = {
    users = {
      kuba = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        group = "kuba";
      };
    };
    groups = {
      kuba = {
        gid = 1000;
      };
    };
  };

  programs.zsh.enable = true;
}
