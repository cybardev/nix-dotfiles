{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

let
  author = "oliverschwendener";
  pname = "ueli";
  version = "9.18.0";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit version;

  src = fetchFromGitHub {
    owner = author;
    repo = pname;
    rev = "v${version}";
    hash = "sha256-8SszM0ZylVFihgC5ZB/tWVMuu3Xeaw3KYyjI9P9LT/8=";
  };

  nativeBuildInputs = with pkgs; [
    nodejs_20
  ];

  configurePhase = ''
    runHook preConfigure
    npm install
    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild
    npm run build
    runHook postBuild
  '';

  checkPhase = ''
    npm run prettier:check
    npm run prettier:write
    npm run lint
    npm run typecheck
    npm run test
  '';

  installPhase = ''
    runHook preInstall
    npm run package
    mkdir -p "$out/Applications"
    cp -R "./release/mac-arm64/Ueli.app" "$out/Applications/"
    runHook postInstall
  '';

  meta = {
    description = "Cross-Platform Keystroke Launcher";
    homepage = "https://github.com/${author}/${pname}";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
