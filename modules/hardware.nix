{ pkgs, ... }:
{
  imports = [
    ./boot.nix
    ./filesystems.nix

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
  ];
}
