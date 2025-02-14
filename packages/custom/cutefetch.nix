{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

let
  author = "cybardev";
  pname = "cutefetch";
  version = "0.4";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit version;

  src = fetchFromGitHub {
    owner = author;
    repo = pname;
    rev = "fc24fbc4db96a20f92d2ac93c34ea611a40ece69";
    hash = "sha256-alDzGTAJYvX4J6nUM9VoH7bIV3YsaaXM8RvB5RAH7Eo=";
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
        lib.makeBinPath (
          [ ]
          ++ lib.optionals pkgs.stdenvNoCC.hostPlatform.isLinux [
            networkmanager
            xorg.xprop
            xorg.xdpyinfo
          ]
        )
      }
  '';

  meta = {
    description = "Tiny coloured fetch script with cute little animals";
    homepage = "https://github.com/${author}/${pname}";
    license = lib.licenses.gpl3Only;
    mainProgram = pname;
    platforms = lib.platforms.all;
  };
}
