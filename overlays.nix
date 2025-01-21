{ pkgs, ... }:
{
  nixpkgs.overlays = [
    # Fix switcheroo-control gobject introspection
    # https://github.com/NixOS/nixpkgs/pull/375411
    (final: prev: {
      switcheroo-control = prev.switcheroo-control.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs ++
          [ prev.wrapGAppsNoGuiHook ];
      });
    })
  ];
}
