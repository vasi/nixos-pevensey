{ ... }:
{
  xdg.desktopEntries.minivmac = {
    name = "Mini vMac";
    icon = "minivmac";
    exec = "minivmac -r /home/vasi/macemu/ROMS/MacPlus.rom /home/vasi/macemu/Images/os6.img /home/vasi/macemu/Images/appsVMac.img";
    categories = [
      "System"
      "Emulator"
    ];
  };

  home.file = {
    ".sheepshaver_prefs".source = ./files/sheepshaver_prefs;
    ".basilisk_ii_prefs".source = ./files/basilisk_ii_prefs;
  };
}
