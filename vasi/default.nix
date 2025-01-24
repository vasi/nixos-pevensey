{ ... }:
{
  imports = [
    <plasma-manager/modules>
    ./cli.nix
    ./code.nix
    ./plasma.nix
  ];

  home = {
    stateVersion = "24.11";
    username = "vasi";
    homeDirectory = "/home/vasi";
  };

  programs.firefox = {
    enable = true;
    profiles.vasi = {
      search.engines."Wikipedia (en)".metaData.alias = "w";
      search.force = true;
      extraConfig = builtins.readFile ./files/user.js;
    };
  };
}
