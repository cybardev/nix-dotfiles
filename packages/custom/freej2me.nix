{
  lib,
  pkgs,
  stdenvNoCC,
  fetchFromGitHub,
}:

let
  author = "TASEmulators";
  pname = "freej2me";
  repo = "${pname}-plus";
  version = "0.0.1";
in
stdenvNoCC.mkDerivation {
  inherit pname;
  inherit version;

  src = fetchFromGitHub {
    owner = author;
    repo = repo;
    rev = "913e2d504452732754b9e2f3d42713c90dbf511a";
    hash = "sha256-7QeS2wRimbfoorMmJdWZdPB4kdS8+22nI/PlmgTMXqk=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
    ant
  ];

  buildInputs = with pkgs; [
    zulu8
  ];

  buildPhase = ''
    runHook preBuild
    ant -noinput -buildfile build.xml
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/bin"
    cp "build/${pname}.jar" "$out/bin/"
    echo "java -jar $out/bin/${pname}.jar" > "$out/bin/${pname}"
    chmod +x "$out/bin/${pname}"
    runHook postInstall
  '';

  postInstall = with pkgs; ''
    wrapProgram "$out/bin/${pname}" \
      --prefix PATH : ${
        lib.makeBinPath (
          [ zulu8 ]
        )
      }
  '';

  meta = {
    description = "A free J2ME emulator with libretro, awt and sdl2 frontends.";
    homepage = "https://github.com/${author}/${repo}";
    license = lib.licenses.gpl3Only;
    mainProgram = pname;
    platforms = lib.platforms.all;
  };
}
