{ ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/7e7c9b05-cfca-42f9-971e-215aec4aff56";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0E13-5426";
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
}
