{ ... }:
{
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
      fondo = "com.github.calo001.fondo";
      cd-os = "cd ~/.config/nixos";
      nix-gc = "nix-collect-garbage -d";

      # editing related
      edit = "nvim";
      edit-vim = "nvim ~/.config/nixos/packages/config/lvim.lua";
      edit-os = "nvim ~/.config/nixos";

      # reloading configs
      re-mac = "darwin-rebuild switch";
      re-nix = "sudo nixos-rebuild switch";
      zrc = ". $ZDOTDIR/.zshrc";

      # package management
      yin = "nix-shell -p";
      yang = "nix-search";
      yup = "sudo nixos-rebuild switch --upgrade";
    };
  };
}
