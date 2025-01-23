{ pkgs, ... }:
let
  myPkgs = import ./packages/default.nix { inherit pkgs; };
in
{
  imports = [
    <nixos-hardware/dell/xps/15-7590/nvidia>
    ./hardware-configuration.nix
    ./modules/hardware.nix
    ./modules/overlays.nix
    ./modules/samba.nix

    {
      # Basic settings
      system.stateVersion = "24.11"; # Affects Nix state locations. Don't change!
      nixpkgs.config.allowUnfree = true;
    }

    # Internationalization
    {
      time.timeZone = "America/Toronto";
      i18n.defaultLocale = "en_CA.UTF-8";
    }

    # Users
    {
      users.users.vasi = {
        isNormalUser = true;
        description = "Dave Vasilevsky";
        extraGroups = [
          "networkmanager"
          "wheel"
          "ydotool"
        ];
        shell = pkgs.zsh;
      };
    }

    # Virtualisation
    {
      virtualisation.vmware.host.enable = true;
      virtualisation.vmware.host.package = pkgs.vmware-workstation.override {
        enableMacOSGuests = true;
      };

    }

    # Desktop
    {
      services.displayManager.sddm.enable = true;
      services.desktopManager.plasma6.enable = true;
      environment.systemPackages =
        with pkgs;
        with kdePackages;
        [
          qtbase
          ksshaskpass
          emote
        ];
    }

    # nix-ld
    {
      programs.nix-ld.enable = true;
    }

    # Emulation
    {
      boot.kernel.sysctl."vm.mmap_min_addr" = 0; # for sheepshaver
      environment.systemPackages =
        with pkgs;
        with myPkgs;
        [
          minivmac
          basiliskii
          sheepshaver

        ];
    }

    # Fuse
    {
      programs.fuse.userAllowOther = true;
    }

    # Apps
    {
      programs = {
        firefox.enable = true;
        git.enable = true;
        zsh.enable = true;
        ydotool.enable = true;
        direnv.enable = true;
        steam.enable = true;
      };
      environment.systemPackages =
        with pkgs;
        with myPkgs;
        [
          # CLI
          file
          rclone
          ripgrep
          ncdu
          pixz
          pv
          killall
          lzopfs

          # Net
          google-chrome
          signal-desktop
          zoom-us
          vlc

          # Dev
          kdePackages.kate
          vscode-fhs
          nixd
          nixfmt-rfc-style
          jetbrains.idea-ultimate
          cntr

          # Misc
          libreoffice
          kdePackages.filelight
        ];
    }

    # Services
    { services.openssh.enable = true; }
  ];
}
