{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  sheepshaver = pkgs.callPackage ./sheepshaver.nix { };
}
