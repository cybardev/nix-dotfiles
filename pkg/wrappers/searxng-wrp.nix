{
  symlinkJoin,
  makeWrapper,
  searxng,
}:
symlinkJoin {
  name = "searxng-wrp";
  paths = [
    searxng
  ];
  buildInputs = [ makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/searxng-run\
      --set SEARXNG_SETTINGS_PATH ${../../cfg/searxng.json}
  '';
}
