{
  pkgs,
  flakePath,
  ...
}: {
  # zshrc
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    autocd = true;
    enableCompletion = true;
    completionInit = "autoload -U compinit && compinit -u";
    defaultKeymap = "viins";
    autosuggestion.enable = true;
    autosuggestion.strategy = [
      "history"
      "completion"
      "match_prev_cmd"
    ];
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    history = {
      save = 1024;
      size = 2048;
      share = true;
      append = true;
      ignoreAllDups = true;
      path = "$ZDOTDIR/history";
    };
    initExtra = ''
      path+=( "$(go env GOPATH)/bin" "$HOME/.local/bin" )
      cutefetch -m text

      fpath+="${pkgs.cy.zen-zsh}"
      autoload -Uz promptinit
      promptinit
      prompt zen
    '';
    shellAliases = {
      zrc = ". $ZDOTDIR/.zshrc";
    };
    dirHashes = {
      nixos = flakePath;
      gitd = "$HOME/Documents/Git";
      testd = "$HOME/test";
    };
  };
}
