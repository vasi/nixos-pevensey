{
  stdenv,
  fetchgit,
  autoreconfHook,
}:
stdenv.mkDerivation {
  pname = "partclone-utils";
  version = "0.3.1-2022-04-25";
  src = fetchgit {
    url = "https://git.code.sf.net/p/partclone-utils/git";
    rev = "e0389ecc4ce301fb08b1199103443b7c4b6a2ec7";
    hash = "sha256-oS4zL+l8oWnxcB0jT2vhEUYdymxxWDTOcpWFDUdyv1o=";
  };
  nativeBuildInputs = [ autoreconfHook ];
}
