{
  stdenv,
  fetchFromGitHub,
  scons,
  pkg-config,
  fuse3,
  lzo,
  xz,
  zlib,
  bzip2,
  zstd,
}:
stdenv.mkDerivation {
  pname = "lzopfs";
  version = "unstable-2025-01-23";
  src = fetchFromGitHub {
    owner = "vasi";
    repo = "lzopfs";
    rev = "1f186d4e99105fdd76a9f3b07c003f2cf0743691";
    hash = "sha256-umko/8GPyH7ft6uJtWCOEslqdBzPJAwHMSQNdH0YPfg=";
  };
  buildInputs = [
    fuse3
    lzo
    xz
    zlib
    bzip2
    zstd
  ];
  nativeBuildInputs = [
    scons
    pkg-config
  ];
  preBuild = ''
    export LDFLAGS="-g $(echo $NIX_LDFLAGS | sed 's/-rpath/-Wl,-rpath/g')"
    export CPPFLAGS="-g -O0 $NIX_CFLAGS_COMPILE"
  '';
  enableParallelBuilding = true;
  installPhase = ''
    runHook preInstall
    install -m 777 -D lzopfs $out/bin/lzopfs
    runHook postInstall
  '';
}
