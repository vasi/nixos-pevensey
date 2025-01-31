{ pkgs, myPkgs, ... }:
{
  imports = [
    <nixos-hardware/dell/xps/15-7590/nvidia>
    <home-manager/nixos>
    ./hardware-configuration.nix
    ./modules/hardware.nix
    ./modules/overlays.nix
    ./modules/samba.nix
    ./modules/packages.nix

    {
      # Basic settings
      system.stateVersion = "24.11"; # Affects Nix state locations. Don't change!
      nixpkgs.config.allowUnfree = true;
      _module.args.myPkgs = import ./packages/default.nix { inherit pkgs; };
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
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.vasi.imports = [ ./vasi/default.nix ];
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

    # Services
    { services.openssh.enable = true; }
  ];
}
