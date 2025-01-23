{
  pkgs ? import <nixpkgs> { },
  ...
}:
{
  sheepshaver = pkgs.callPackage ./sheepshaver.nix { };
  lzopfs = pkgs.callPackage ./lzopfs.nix { };
  partclone-utils = pkgs.callPackage ./partclone-utils.nix { };
}
