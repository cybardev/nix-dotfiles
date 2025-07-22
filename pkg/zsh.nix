{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (config.userConfig) flakePath;
  zshPlugin = plugin: {
    name = plugin;
    src = pkgs.${plugin};
    file = "share/zsh/site-functions/${plugin}.plugin.zsh";
  };
  zshPlugins = plugins: map zshPlugin plugins;
in
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

      mkdev() {
        [[ -f .gitignore ]] && echo "\n" >> .gitignore
        cat ${../cfg/devshell/gitignore} >> .gitignore
        cat ${../cfg/devshell/shell.nix} >   shell.nix
        cat ${../cfg/devshell/flake.nix} >   flake.nix
        echo "use flake"                 >> .envrc
        direnv allow
      }

      ZSH_AUTOSUGGEST_STRATEGY=( abbreviations $ZSH_AUTOSUGGEST_STRATEGY )
    '';
    shellAliases = {
      src = "exec zsh";
      fm = "f() { cd \"$(${lib.getExe pkgs.lf} -print-last-dir \"$@\")\" }; f";
      fan = "f() { du -hd1 \"$1\" | sort -hr }; f";
      unly = "f() { curl -Is \"$1\" | grep ^location | cut -d \" \" -f 2 }; f";
      etch = "f() { sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync }; f";
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
    plugins = zshPlugins [
      "zsh-autosuggestions-abbreviations-strategy"
    ];
  };
}
