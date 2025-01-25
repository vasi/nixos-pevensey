{ pkgs, myPkgs, ... }:
{
  networking.hostId = "4a9dbe3c";
  boot.supportedFilesystems = {
    ext = true;
    xfs = true;
    btrfs = true;
    vfat = true;
    ntfs = true;
    exfat = true;
    apfs = true;
    zfs = true;
  };
  environment.systemPackages =
    with pkgs;
    with myPkgs;
    [
      parted
      gparted
      gptfdisk
      hfsprogs
      partclone-utils
    ];

  # Fix hibernation
  boot.zfs.allowHibernation = true;
  boot.zfs.forceImportRoot = false;

  programs.fuse.userAllowOther = true;
  programs.nbd.enable = true;
  services.gvfs.enable = true;
}
