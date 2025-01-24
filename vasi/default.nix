{ ... }:
{
  imports = [
    <plasma-manager/modules>
    ./home.nix
    ./plasma.nix
  ];

  home = {
    stateVersion = "24.11";
    username = "vasi";
    homeDirectory = "/home/vasi";
  };
}
