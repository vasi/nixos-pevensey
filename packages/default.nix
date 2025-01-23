{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  sheepshaver = pkgs.callPackage ./sheepshaver.nix { };
  lzopfs = pkgs.callPackage ./lzopfs.nix { };
}
