{
  lib,
  pkgs,
  fetchFromGitHub,
}:

let
  author = "aseprite";
  pname = "aseprite";
  version = "1.3.12";
  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = author;
    repo = pname;
    tag = "v${version}";
    hash = "sha256-hs+pKk7GcVGVyelRfipy5JQCgygrBhPb7E5uXVapflw=";
  };
in
pkgs.stdenv.mkDerivation {
  inherit pname;
  inherit version;
  inherit src;

  nativeBuildInputs = with pkgs; [
    pkg-config
    cmake
    ninja
  ];

  args = [
    "${src}/build.sh"
    "--auto"
  ];

  meta = {
    homepage = "https://www.aseprite.org/";
    description = "Animated sprite editor & pixel art tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    mainProgram = pname;
  };
}
