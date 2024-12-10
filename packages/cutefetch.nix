{
  lib,
  pkgs,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "cutefetch";
  version = "0.3";

  src = fetchFromGitHub {
    owner = "cybardev";
    repo = "cutefetch";
    rev = "e2462c64926f405f3c840efb37803def97c145ed";
    hash = "sha256-DMp8tc1r5g3kHtboRp2xmx1o3Ze5UMqoYUHQwlT/gbI=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  buildPhase = ''
    runHook preBuild
    chmod +x cutefetch
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp cutefetch $out/bin/
    runHook postInstall
  '';

  postInstall = with pkgs; ''
    wrapProgram $out/bin/cutefetch \
      --prefix PATH : ${lib.makeBinPath [ networkmanager xorg.xprop xorg.xdpyinfo ]}
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
