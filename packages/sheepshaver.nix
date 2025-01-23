{
  stdenv,
  fetchFromGitHub,
  autoconf,
  automake,
  pkg-config,
  file,
  makeDesktopItem,
  copyDesktopItems,
  libicns,
  SDL2,
  perl,
}:
stdenv.mkDerivation (final: {
  pname = "sheepshaver";
  version = "unstable-2025-01-22";

  src = fetchFromGitHub {
    owner = "kanjitalk755";
    repo = "macemu";
    rev = "63e28afb8e76f428a2bfac63942ea47982925ab8";
    hash = "sha256-CGzKCP1+R3bezk6tvxQ8exs0tENf/ee2Joc2mY3CMF8=";
  };
  sourceRoot = "${final.src.name}/SheepShaver/src/Unix";
  nativeBuildInputs = [
    autoconf
    automake
    pkg-config
    file
    copyDesktopItems
    libicns
    perl
  ];
  buildInputs = [ SDL2 ];
  prePatch = "substituteInPlace Linux/scsi_linux.cpp --replace-quiet linux/../scsi/sg.h scsi/sg.h";
  preConfigure = ''
    chmod +w ../MacOSX
    substituteInPlace configure.ac --replace-quiet "/usr/bin/file" file
    NO_CONFIGURE=1 ./autogen.sh
  '';
  enableParallelBuilding = true;
  postInstall = ''
    icns2png -x ../MacOSX/SheepShaver.icns
    for size in 16 32 48 128 256 512 1024; do
      install -Dm444 SheepShaver_"$size"x"$size"x32.png "$out/share/icons/hicolor/"$size"x"$size"/apps/SheepShaver.png"
    done
  '';
  desktopItems = [
    (makeDesktopItem {
      name = "SheepShaver";
      desktopName = "SheepShaver";
      exec = "SheepShaver";
      icon = "SheepShaver";
      categories = [
        "System"
        "Emulator"
      ];
    })
  ];
})
