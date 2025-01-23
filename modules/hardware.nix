{ pkgs, myPkgs, ... }:
{
  imports = [
    # Bootloader
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.systemd-boot.configurationLimit = 20;
      boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
      boot.loader.efi.efiSysMountPoint = "/efi";
      boot.loader.efi.canTouchEfiVariables = false;
    }

    # Boot
    { boot.initrd.systemd.enable = true; }

    # Boot splash
    {
      boot.plymouth.enable = true;
      boot.initrd.verbose = false;
      boot.consoleLogLevel = 0;
      boot.kernelParams = [
        "quiet"
        "udev.log_level=3"
      ];
    }

    # Swap
    {
      boot.kernelParams = [ "zswap.enabled=1" ];
      swapDevices = [
        {
          device = "/swapfile";
          size = 9 * 1024;
        }
      ];
    }

    # Networking
    {
      networking.hostName = "pevensey";
      networking.networkmanager.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
        };
      };
      networking.firewall.checkReversePath = false;
    }

    # Bluetooth
    {
      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    }

    # Xorg
    {
      services.xserver.enable = true;
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    }

    # GPU
    { services.switcherooControl.enable = true; }

    # Power management
    {
      services.power-profiles-daemon.enable = false;
      services.tlp.enable = true;
      powerManagement.powertop.enable = true;
      services.undervolt = {
        enable = true;
        coreOffset = -100;
      };
    }

    # Printer/scanner
    {
      services.printing.enable = true;
      hardware.sane.extraBackends = [ pkgs.sane-airscan ];
      environment.systemPackages = [
        (pkgs.kdePackages.skanpage.override {
          tesseractLanguages = [
            "eng"
            "fra"
          ];
        })
      ];
    }

    # Audio
    {
      hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    }

    # Filesystems
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
      programs.fuse.userAllowOther = true;
      programs.nbd.enable = true;
    }
  ];
}
