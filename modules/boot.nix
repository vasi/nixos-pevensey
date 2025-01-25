{ myPkgs, ... }:
{
  boot.initrd.systemd.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 20;
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.efi.canTouchEfiVariables = false;
  environment.systemPackages = [ myPkgs.refind-switch ];

  # Splash
  boot.plymouth.enable = true;
  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
  ];
}
