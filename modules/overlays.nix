{ lib, ... }:
{
  nixpkgs.overlays = [
    # Fix switcheroo-control gobject introspection
    # https://github.com/NixOS/nixpkgs/pull/375411
    (final: prev: {
      switcheroo-control = prev.switcheroo-control.overrideAttrs (old: {
        nativeBuildInputs = old.nativeBuildInputs ++ [ prev.wrapGAppsNoGuiHook ];
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
        preFixup =
          old.preFixup
          + ''
            makeWrapperArgs+=(--prefix PATH : ${lib.makeBinPath [ prev.ydotool ]})
          '';
      });
    })

    # Enable JIT in basiliskii, and use newer checkout
    (final: prev: {
      basiliskii = prev.basiliskii.overrideAttrs (old: {
        version = "unstable-2025-01-22";
        src = old.src // {
          rev = "63e28afb8e76f428a2bfac63942ea47982925ab8";
        };
        nativeBuildInputs = old.nativeBuildInputs ++ [
          prev.copyDesktopItems
          prev.libicns
        ];
        configureFlags = old.configureFlags ++ [
          "--enable-jit-compiler"
        ];
        enableParallelBuilding = true;
        postInstall = ''
          icns2png -x ../MacOSX/BasiliskII.icns
          for size in 16 32 64 128 256 512 1024; do
            install -Dm444 BasiliskII_"$size"x"$size"x32.png "$out/share/icons/hicolor/"$size"x"$size"/apps/basiliskii.png"
          done
        '';
        desktopItems = [
          (prev.makeDesktopItem {
            name = "Basilisk II";
            desktopName = "Basilisk II";
            exec = "BasiliskII";
            icon = "basiliskii";
            categories = [
              "System"
              "Emulator"
            ];
          })
        ];
      });
    })

    # Export icon from Mini vMac
    (final: prev: {
      minivmac = prev.minivmac.overrideAttrs (old: {
        enableParallelBuilding = true;
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.libicns ];
        installPhase = # Doesn't call hooks!
          old.installPhase
          + ''
            icns2png -x src/ICONAPPO.icns
            for size in 16 32; do
              install -Dm444 ICONAPPO_"$size"x"$size"x8.png "$out/share/icons/hicolor/"$size"x"$size"/apps/minivmac.png"
            done
          '';
      });
    })
  ];
}
