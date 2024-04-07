{ pkgs, ... }:
{
  users.users = {
    root = {
      shell = pkgs.bashInteractive;
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHl+04jyGhii2HP9z9D6UB0p8ypnxOAthrmidm2aJa0j zakaprov@gmail.com" ];
    };
  };
}
