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
      cutefetch

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
      tree = "eza --tree --group-directories-last --sort=extension";
      py = "ptpython --config-file ~/.config/ptpython/config.py";
      yt = "ytgo -i -m -p";
      cf = "cutefetch";
      nvim = "lvim";
      fondo = "com.github.calo001.fondo";
      cd-os = "cd ~/.config/nixos";
      nix-gc = "nix-collect-garbage -d";

      # editing related
      edit = "nvim";
      edit-vim = "nvim ~/.config/nvim/lua/plugins/user.lua";
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
