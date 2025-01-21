{ lib, ... }:
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

    # Allow Emote to paste in Wayland
    (final: prev: {
      emote = prev.emote.overrideAttrs (old: {
        patches = [
          (prev.fetchpatch2 {
            url = "https://aur.archlinux.org/cgit/aur.git/plain/emote_wayland_autopaste.patch?h=emote&id=45f9ca3752bc759a838cdd38f9c798bf157c91ce";
            hash = "sha256-OG3vkGaBkeCTDydz6bdWOZpLjsQCdgOREolW7AKjWJM=";
          })
        ];
        preFixup = old.preFixup + ''
          makeWrapperArgs+=(--prefix PATH : ${
            lib.makeBinPath [ prev.ydotool ]
          })
        '';
      });
    })
  ];
}
