{
  pkgs,
  fetchFromGitHub,
}:

let
  pname = "ptpython";
  version = "3.0.29";
in
pkgs.python3Packages.buildPythonApplication {
  inherit pname;
  inherit version;

  propagatedBuildInputs = with pkgs.python3Packages; [
    appdirs
    importlib-metadata
    jedi
    prompt-toolkit
    pygments
  ];

  src = fetchFromGitHub {
    owner = "prompt-toolkit";
    repo = pname;
    rev = version;
    hash = "sha256-2b2urIjGrdlbekTAsWQS6TB1aknq8fSRNtP/97i+92c=";
  };
}
