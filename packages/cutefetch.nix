{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "cutefetch";
  version = "0.2";

  src = fetchFromGitHub {
    owner = "cybardev";
    repo = "cutefetch";
    rev = "e2462c64926f405f3c840efb37803def97c145ed";
    hash = "sha256-DMp8tc1r5g3kHtboRp2xmx1o3Ze5UMqoYUHQwlT/gbI=";
  };

  # specify runtime dependencies
  buildInputs = with pkgs; [ networkmanager xorg.xprop xorg.xdpyinfo ];
  buildPhase = ''
    runHook preBuild
    echo "${pkgs.networkmanager}/bin/nmcli" >> .deps
    echo "${pkgs.xorg.xdpyinfo}/bin/xdpyinfo" >> .deps
    echo "${pkgs.xorg.xprop}/bin/xprop" >> .deps
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp .deps $out/
    chmod +x cutefetch
    cp cutefetch $out/bin/
    runHook postInstall
  '';

  meta = {
    description = "Tiny coloured fetch script with cute little animals";
    homepage = "https://github.com/cybardev/cutefetch";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "cutefetch";
    platforms = lib.platforms.all;
  };
}
