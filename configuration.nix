{ config, pkgs, ... }:
{
  imports = [
    <nixos-hardware/dell/xps/15-7590>
    ./hardware-configuration.nix
    ./overlays.nix
  ];

  # Original release, used for state locations. Don't change!
  system.stateVersion = "24.11";

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.efi.canTouchEfiVariables = false;

  boot.kernelParams = [ "zswap.enabled=1" ];
  swapDevices = [{
    device = "/swapfile";
    size = 9 * 1024;
  }];

  networking.hostName = "pevensey";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.switcherooControl.enable = true;
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];
  hardware.nvidia.open = true;

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.vasi = {
    isNormalUser = true;
    description = "Dave Vasilevsky";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs = {
    firefox.enable = true;
    git.enable = true;
    zsh.enable = true;
  };
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    kdePackages.ksshaskpass
    signal-desktop
  ];

  services.openssh.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    publish = {
      enable = true;
      addresses = true;
    };
  };
}
