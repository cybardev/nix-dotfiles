{
  pkgs,
  fetchFromGitHub,
}:

pkgs.python3Packages.buildPythonApplication {
  pname = "ptpython";
  version = "3.0.29";

  propagatedBuildInputs = with pkgs.python3Packages; [
    appdirs
    importlib-metadata
    jedi
    prompt-toolkit
    pygments
  ];

  src = fetchFromGitHub {
    owner = "prompt-toolkit";
    repo = "ptpython";
    rev = "3.0.29";
    hash = "sha256-2b2urIjGrdlbekTAsWQS6TB1aknq8fSRNtP/97i+92c=";
  };
}

