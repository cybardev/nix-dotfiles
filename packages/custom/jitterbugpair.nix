{
  lib,
  pkgs,
  stdenvNoCC,
}:

let
  author = "osy";
  pname = "Jitterbug";
  version = "1.3.1";
  os = (if stdenvNoCC.hostPlatform.isLinux then "linux" else "macos");
in
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit version;

  src = pkgs.fetchzip {
    url = "https://github.com/osy/Jitterbug/releases/download/v${version}/jitterbugpair-${os}.zip";
    hash = (if stdenvNoCC.hostPlatform.isLinux
      then "sha256-xQ+thkNy9fKUOi80FgfFham3NAZ6VgXbahzkAtdS6cg="
      else "sha256-LM0jYQ64OVgCAaBNfVb39THkf+UcS4SnG9fArYdwY0U=");
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall
    chmod +x jitterbugpair
    mkdir -p "$out/bin"
    cp jitterbugpair "$out/bin/"
    runHook postInstall
  '';

  meta = {
    description = "Software to generate a pairing token for Jitterbug";
    homepage = "https://github.com/${author}/${pname}";
    license = lib.licenses.asl20;
    mainProgram = "jitterbugpair";
    platforms = lib.platforms.all;
  };
}
