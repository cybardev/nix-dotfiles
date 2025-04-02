{ pkgs, userConfig, ... }:
let
  nixConfigDir = userConfig.nixos;
in
{
  # custom prompt
  home.file.".config/zsh/zen".source = pkgs.fetchFromGitHub {
    owner = "cybardev";
    repo = "zen.zsh";
    rev = "v2.0";
    hash = "sha256-s/YLFdhCrJjcqvA6HuQtP0ADjBtOqAP+arjpFM2m4oQ=";
  };

  # zshrc
  programs.zsh = {
    dotDir = ".config/zsh";
    enable = true;
    autocd = true;
    enableCompletion = true;
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

      fpath+="$ZDOTDIR/zen"
      autoload -Uz promptinit
      promptinit
      prompt zen

      function etch() {
        sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync
      }

      function unly() {
        curl -Is "$1" | grep ^location | cut -d ' ' -f 2
      }
    '';
    shellAliases = {
      # shell conveniences
      x = "exit";
      clr = "clear";
      cls = "clear";
      cat = "bat -pp";
      icat = "kitten icat";
      ls = "eza -1 --icons=never";
      ll = "eza -1l";
      tree = "eza --tree";
      py = "ptpython";
      yt = "ytgo -i -m -p";
      cf = "cutefetch";
      tf = "cutefetch -m text";
      nvim = "lvim";
      cd-os = "cd ~/.config/nixos";

      # editing related
      edit = "nvim";
      edit-vim = "nvim ${nixConfigDir}/packages/config/lvim.lua";
      edit-os = "nvim ${nixConfigDir}";

      # reloading configs
      zrc = ". $ZDOTDIR/.zshrc";

      # package management
      yin = "nix-shell -p";
      yang = "nix-search";
      wuji = "nix-collect-garbage -d && sudo -H nix-collect-garbage -d";
      yup = "nix flake update --flake ${nixConfigDir} && re-nix";
    };
  };
}
