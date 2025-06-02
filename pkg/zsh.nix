{
  pkgs,
  flakePath,
  ...
}:
{
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
    historySubstringSearch = {
      enable = true;
      searchUpKey = [ "^[OA" ];
      searchDownKey = [ "^[OB" ];
    };
    history = {
      save = 1024;
      size = 2048;
      share = true;
      append = true;
      ignoreAllDups = true;
      path = "$ZDOTDIR/history";
    };
    initContent = ''
      path+=( "$(go env GOPATH)/bin" "$HOME/.local/bin" )
      cutefetch -m text

      fpath+="${pkgs.cy.zen-zsh}"
      autoload -Uz promptinit
      promptinit
      prompt zen

      ZSH_AUTOSUGGEST_STRATEGY=( abbreviations $ZSH_AUTOSUGGEST_STRATEGY )
    '';
    shellAliases = {
      zrc = ". $ZDOTDIR/.zshrc";
    };
    dirHashes = {
      nixos = flakePath;
      gitd = "$HOME/Documents/Git";
      testd = "$HOME/test";
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        ga = "git add";
        gc = "git commit";
        gaa = "git add --all";
        gca = "git commit --amend";
        gcf = "git commit --fixup";
        gcm = "git commit --message";
        grb = "git rebase --interactive";
        gcam = "git commit --amend --message";
        grbs = "git rebase --interactive --autosquash";
      };
    };
    plugins = [
      {
        name = pkgs.zsh-autosuggestions-abbreviations-strategy.name;
        src = pkgs.zsh-autosuggestions-abbreviations-strategy;
      }
    ];
  };
}
