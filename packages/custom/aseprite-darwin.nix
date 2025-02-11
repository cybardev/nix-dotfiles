{
  lib,
  pkgs,
  clangStdenv,
  fetchFromGitHub,
  fetchpatch,
  gitUpdater,
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

  patches = [
    (fetchpatch {
      name = "shared-skia-deps.patch";
      url = "https://raw.githubusercontent.com/NixOS/nixpkgs/898e16ba93cfe4a1879f022dccd1ea877e25abe0/pkgs/by-name/as/aseprite/shared-skia-deps.patch";
      hash = "sha256-rGMxfSMr4QhRmtnCArUPEI32SXfFnURdf+5dTcqvGE4=";
    })
  ];

  postPatch =
    let
      # Translation strings
      strings = fetchFromGitHub {
        owner = "aseprite";
        repo = "strings";
        rev = "7b0af61dec1d98242d7eb2e9cab835d442d21235";
        hash = "sha256-8OwwHCFP55pwLjk5O+a36hDZf9uX3P7cNliJM5SZdAg=";
      };
    in
    ''
      sed -i src/ver/CMakeLists.txt -e "s-set(VERSION \".*\")-set(VERSION \"$version\")-"
      rm -rf data/strings
      cp -r ${strings} data/strings
    '';

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
    "-G Ninja"
  ];

  passthru.updateScript = gitUpdater { rev-prefix = "v"; };

  meta = {
    homepage = "https://www.aseprite.org/";
    description = "Animated sprite editor & pixel art tool";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    mainProgram = pname;
  };
}
