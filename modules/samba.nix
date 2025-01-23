{ ... }:
{
  services.samba = {
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        workgroup = "WORKGROUP";
        "server role" = "standalone server";
        "obey pam restrictions" = "yes";
        "map to guest" = "bad user";
      };
      homes = {
        comment = "Home Directories";
        browseable = "yes";
        "read only" = "no";
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S";
      };
    };
  };
}
