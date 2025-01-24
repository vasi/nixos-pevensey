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
}
