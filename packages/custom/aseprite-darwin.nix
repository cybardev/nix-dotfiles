{
  lib,
  pkgs,
  clangStdenv,
  fetchFromGitHub,
}:

let
  author = "aseprite";
  pname = "aseprite";
  version = "1.3.12";
in
clangStdenv.mkDerivation {
  inherit pname;
  inherit version;

  src = fetchFromGitHub {
    fetchSubmodules = true;
    owner = author;
    repo = pname;
    rev = "v" + version;
    hash = "sha256-hs+pKk7GcVGVyelRfipy5JQCgygrBhPb7E5uXVapflw=";
  };

  nativeBuildInputs = with pkgs; [
    apple-sdk_11
    libtool
  ];
  buildInputs = with pkgs; [
    skia-aseprite
  ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
    "-DCMAKE_OSX_ARCHITECTURES=arm64"
    "-DCMAKE_OSX_DEPLOYMENT_TARGET=11.0"
    "-DCMAKE_OSX_SYSROOT=${pkgs.apple-sdk_11}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
    "-DLAF_BACKEND=skia"
    "-DSKIA_DIR=${pkgs.skia-aseprite}"
    "-DSKIA_LIBRARY_DIR=${pkgs.skia-aseprite}/lib"
    "-DSKIA_LIBRARY=${pkgs.skia-aseprite}/lib/libskia.a"
    "-DPNG_ARM_NEON:STRING=on"
  ];

  meta = {
    homepage = "https://www.aseprite.org/";
    description = "Animated sprite editor & pixel art tool";
    license = lib.licenses.unfree;
    maintainers = with lib.maintainers; [ ];
    platforms = lib.platforms.darwin;
    mainProgram = pname;
  };
}
