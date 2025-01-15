{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = finalAttrs.src.repo;
  version = "0.3";

  src = fetchFromGitHub {
    owner = "cybardev";
    repo = "cutefetch";
    rev = "e2462c64926f405f3c840efb37803def97c145ed";
    hash = "sha256-DMp8tc1r5g3kHtboRp2xmx1o3Ze5UMqoYUHQwlT/gbI=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  installPhase = ''
    runHook preInstall
    chmod +x ${finalAttrs.src.repo}
    mkdir -p "$out/bin"
    cp ${finalAttrs.src.repo} "$out/bin/"
    runHook postInstall
  '';

  postInstall = with pkgs; ''
    wrapProgram "$out/bin/${finalAttrs.src.repo}" \
      --prefix PATH : ${
        lib.makeBinPath [ ]
        ++ lib.optional pkgs.stdenvNoCC.hostPlatform.isLinux networkmanager xorg.xprop xorg.xdpyinfo
      }
  '';

  meta = {
    description = "Tiny coloured fetch script with cute little animals";
    homepage = "https://github.com/${finalAttrs.src.owner}/${finalAttrs.src.repo}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = finalAttrs.src.repo;
    platforms = lib.platforms.all;
  };
})
