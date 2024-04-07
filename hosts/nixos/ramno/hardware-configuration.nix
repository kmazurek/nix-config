{ lib, ... }:
let
  boot-device = "/dev/disk/by-uuid/0E13-5426";
in
{
  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usb_storage" "sd_mod" ];
      systemd.enable = true;
    };
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    # loader.grub = {
    #   enable = true;
    #   version = 2;
    #   device = boot-device;
    # };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
    opengl.enable = true;
    opengl.driSupport = true;
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7e7c9b05-cfca-42f9-971e-215aec4aff56";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = boot-device;
    fsType = "vfat";
  };

  fileSystems."/mnt/data1" = {
    device = "/dev/disk/by-label/data1";
    fsType = "xfs";
  };

  fileSystems."/mnt/data2" = {
    device = "/dev/disk/by-label/data2";
    fsType = "xfs";
  };

  fileSystems."/mnt/parity1" = {
    device = "/dev/disk/by-label/parity1";
    fsType = "xfs";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
