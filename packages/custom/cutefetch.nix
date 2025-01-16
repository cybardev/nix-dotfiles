{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

let
  author = "cybardev";
  pname = "cutefetch";
  version = "0.3";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit version;

  src = fetchFromGitHub {
    owner = author;
    repo = pname;
    rev = "e2462c64926f405f3c840efb37803def97c145ed";
    hash = "sha256-DMp8tc1r5g3kHtboRp2xmx1o3Ze5UMqoYUHQwlT/gbI=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    runHook preInstall
    chmod +x ${pname}
    mkdir -p "$out/bin"
    cp ${pname} "$out/bin/"
    runHook postInstall
  '';

  postInstall = with pkgs; ''
    wrapProgram "$out/bin/${pname}" \
      --prefix PATH : ${
        lib.makeBinPath [ ]
        ++ lib.optional pkgs.stdenvNoCC.hostPlatform.isLinux networkmanager xorg.xprop xorg.xdpyinfo
      }
  '';

  meta = {
    description = "Tiny coloured fetch script with cute little animals";
    homepage = "https://github.com/${author}/${pname}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = pname;
    platforms = lib.platforms.all;
  };
}
