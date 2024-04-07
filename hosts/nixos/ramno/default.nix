{ inputs, config, lib, vars, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "ramno";
    useDHCP = true;
  };

  systemd.services.hd-idle = {
    description = "HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 900";
    };
  };

  system.autoUpgrade.enable = true;

  environment.systemPackages = with pkgs; [
    pciutils
    glances
    hdparm
    hd-idle
    hddtemp
    smartmontools
    powertop
    cpufrequtils
    gnumake
    gcc
    intel-gpu-tools
    gptfdisk
    xfsprogs
    parted
    snapraid
    mergerfs
    mergerfs-tools
  ];

  system.StateVersion = "23.11";
}
