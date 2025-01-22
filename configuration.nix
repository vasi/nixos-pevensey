{ lib, pkgs, ... }:
{
  imports = [
    <nixos-hardware/dell/xps/15-7590/nvidia>
    ./hardware-configuration.nix
    ./overlays.nix

    { # Original release, used for state locations. Don't change!
      system.stateVersion = "24.11";

      nixpkgs.config.allowUnfree = true;
    }

    { boot.loader.systemd-boot.enable = true;
      boot.loader.systemd-boot.configurationLimit = 20;
      boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
      boot.loader.efi.efiSysMountPoint = "/efi";
      boot.loader.efi.canTouchEfiVariables = false;
    }

    { boot.initrd.systemd.enable = true; }

    { boot.plymouth.enable = true;
      boot.initrd.verbose = false;
      boot.consoleLogLevel = 0;
      boot.kernelParams = [ "quiet" "udev.log_level=3" ];
    }

    { boot.kernelParams = [ "zswap.enabled=1" ];
      swapDevices = [{
        device = "/swapfile";
        size = 9 * 1024;
      }];
    }

    { networking.hostName = "pevensey";
      networking.networkmanager.enable = true;
      services.avahi = {
        enable = true;
        nssmdns4 = true;
        publish = {
          enable = true;
          addresses = true;
        };
      };
    }

    { hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    }

    { time.timeZone = "America/Toronto";
      i18n.defaultLocale = "en_CA.UTF-8";
    }

    { services.xserver.enable = true;
      services.xserver.xkb = {
        layout = "us";
        variant = "";
      };
    }

    { services.switcherooControl.enable = true; }

    { services.power-profiles-daemon.enable = false;
      services.tlp.enable = true;
      powerManagement.powertop.enable = true;
    }

    { services.printing.enable = true;
      hardware.sane.extraBackends = [ pkgs.sane-airscan ];
      environment.systemPackages = [
        (pkgs.kdePackages.skanpage.override {
          tesseractLanguages = ["eng" "fra"];
        })
      ];
    }

    { hardware.pulseaudio.enable = false;
      security.rtkit.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    }

    { services.undervolt = {
        enable = true;
        coreOffset = -100;
      };
    }


    { networking.hostId = "4a9dbe3c";
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
      environment.systemPackages = with pkgs; [
        parted
        gparted
        gptfdisk
        hfsprogs
      ];
    }

    { users.users.vasi = {
        isNormalUser = true;
        description = "Dave Vasilevsky";
        extraGroups = [ "networkmanager" "wheel" "ydotool" ];
        shell = pkgs.zsh;
      };
    }

    { virtualisation.vmware.host.enable = true;
      virtualisation.vmware.host.package = pkgs.vmware-workstation.override {
        enableMacOSGuests = true;
      };

    }

    { services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
      environment.systemPackages = with pkgs; with kdePackages; [
        qtbase
        ksshaskpass
        emote
      ];
    }


    { programs = {
        firefox.enable = true;
        git.enable = true;
        zsh.enable = true;
        ydotool.enable = true;
        direnv.enable = true;
      };
      environment.systemPackages = with pkgs; [
        # CLI
        file
        rclone
        ripgrep
        ncdu

        # Admin
        kdePackages.filelight

        # Office
        kdePackages.kate
        libreoffice

        # Net
        google-chrome
        signal-desktop
        zoom-us
      ];
    }

    { services.openssh.enable = true; }
  ];
}
