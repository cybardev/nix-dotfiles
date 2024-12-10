{
  lib,
  pkgs,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "ytgo";
  version = "3.1.3";

  src = fetchFromGitHub {
    owner = "cybardev";
    repo = "ytgo";
    rev = "v${version}";
    hash = "sha256-cAnZfXwk4zv9I8FDDe+xpR3TxlMgJjiLPT9h61iEqVY=";
  };

  nativeBuildInputs = [ pkgs.makeWrapper ];

  vendorHash = "sha256-62bDFcunLygMpAY63C/b3g9L97XZ9HZbmz4RMecJwO4=";

  ldflags = [ "-s" "-w" ];

  doCheck = false;

  postFixup = with pkgs; ''
    wrapProgram $out/bin/ytgo \
      --prefix PATH : ${lib.makeBinPath [ ffmpeg yt-dlp mpv ]}
  '';

  meta = {
    description = "A Go program to find and watch YouTube videos from the terminal without requiring API keys";
    homepage = "https://github.com/cybardev/ytgo";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "ytgo";
  };
}
