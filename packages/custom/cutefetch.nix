{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (
  finalAttrs:
  let
    src = fetchFromGitHub {
      owner = "cybardev";
      repo = "cutefetch";
      rev = "e2462c64926f405f3c840efb37803def97c145ed";
      hash = "sha256-DMp8tc1r5g3kHtboRp2xmx1o3Ze5UMqoYUHQwlT/gbI=";
    };
  in
  {
    inherit src;

    pname = src.repo;
    version = "0.3";

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      runHook preInstall
      chmod +x cutefetch
      mkdir -p "$out/bin"
      cp cutefetch "$out/bin/"
      runHook postInstall
    '';

    postInstall = with pkgs; ''
      wrapProgram "$out/bin/cutefetch" \
        --prefix PATH : ${
          lib.makeBinPath [ ]
          ++ lib.optional pkgs.stdenvNoCC.hostPlatform.isLinux networkmanager xorg.xprop xorg.xdpyinfo
        }
    '';

    meta = {
      description = "Tiny coloured fetch script with cute little animals";
      homepage = "https://github.com/${src.owner}/${src.repo}";
      license = lib.licenses.gpl3Only;
      maintainers = with lib.maintainers; [ ];
      mainProgram = src.repo;
      platforms = lib.platforms.all;
    };
  }
)
