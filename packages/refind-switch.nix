{
  stdenv,
  fetchFromGitHub,
  makeDesktopItem,
  copyDesktopItems,
}:
stdenv.mkDerivation {
  pname = "refind-switch";
  version = "unstable-2025-01-21";
  src = fetchFromGitHub {
    owner = "vasi";
    repo = "refind-switch";
    rev = "1161858ef4546e1eb68df4e7c48e694a893897aa";
    hash = "sha256-1IzeX5MNNWuGCRbuZkykBFOds6k9cI4tjc0D0MgaNKY=";
  };
  nativeBuildInputs = [ copyDesktopItems ];
  desktopItems = [
    (makeDesktopItem {
      name = "boot-windows";
      exec = "boot-windows";
      desktopName = "Reboot into Windows";
      type = "Application";
      icon = "boot-windows";
    })
  ];
  postInstall = ''
    install -Dm 755 boot-windows.sh $out/bin/boot-windows
    install -Dm 644 win11.png $out/share/icons/hicolor/64x64/apps/boot-windows.png
  '';
}
