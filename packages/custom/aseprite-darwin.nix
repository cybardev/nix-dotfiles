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
    tag = "v${version}";
    hash = "sha256-hs+pKk7GcVGVyelRfipy5JQCgygrBhPb7E5uXVapflw=";
  };

  nativeBuildInputs = with pkgs; [
    apple-sdk_11
  ];
  buildInputs = with pkgs; [
    skia-aseprite
  ];

  cmakeFlags = with pkgs; [
    "-DCMAKE_BUILD_TYPE=RelWithDebInfo"
    "-DCMAKE_OSX_ARCHITECTURES=arm64"
    "-DCMAKE_OSX_DEPLOYMENT_TARGET=11.0"
    "-DCMAKE_OSX_SYSROOT=${apple-sdk_11}/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
    "-DLAF_BACKEND=skia"
    "-DSKIA_DIR=${skia-aseprite}"
    "-DSKIA_LIBRARY_DIR=${skia-aseprite}/lib"
    "-DSKIA_LIBRARY=${skia-aseprite}/lib/libskia.a"
    "-DPNG_ARM_NEON:STRING=on"
  ];

  meta = {
    homepage = "https://www.aseprite.org/";
    description = "Animated sprite editor & pixel art tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    mainProgram = pname;
  };
}
