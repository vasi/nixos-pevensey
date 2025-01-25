{
  dconf.settings = {
    "org/gnome/deja-dup" = {
      backend = "remote";
      delete-after = 182;
      exclude-list = [
        "$TRASH"
        "$DOWNLOAD"
        "/home/vasi/.cache"
        "/etc/fwupd"
        "/etc/ipsec.d"
        "/etc/NetworkManager"
        "/etc/.pwd.lock"
        "/etc/shadow"
        "/etc/shadow-"
        "/etc/ssh"
        "/etc/sudoers"
        "/etc/vmware"
        "/etc/vmware-installer"
      ];
      include-list = [
        "$HOME"
        "/etc"
      ];
      periodic = true;
      periodic-period = 7;
      tool = "duplicity";
    };
    "org/gnome/deja-dup/remote" = {
      folder = "pevensey-nixos";
      uri = "sftp://dali.local/srv/backup";
    };
  };
}
