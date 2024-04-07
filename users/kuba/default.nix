{ pkgs, ... }:
{
  nix.settings.trusted-users = [ "kuba" ];

  users = {
    users = {
      kuba = {
        shell = pkgs.zsh;
        uid = 1000;
        isNormalUser = true;
        extraGroups = [ "wheel" "users" ];
        group = "kuba";
        openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl+04jyGhii2HP9z9D6UB0p8ypnxOAthrmidm2aJa0j zakaprov@gmail.com" ];
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
