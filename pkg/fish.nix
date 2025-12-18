{ pkgs, lib, ... }:
{
  programs.fish = {
    enable = false;
    shellInit = ''
      fish_add_path ~/.local/bin
      fish_vi_key_bindings
    '';
    functions = {
      fish_greeting.body = "cutefetch -m text";
      src.body = "exec fish";
      fm.body = "cd \"$(${lib.getExe pkgs.lf} -print-last-dir \"$argv\")\"";
      fan.body = "du -hd1 \"$argv[1]\" | sort -hr";
      unly.body = "curl -Is \"$argv[1]\" | grep ^location | cut -d \" \" -f 2";
      etch.body = "sudo dd bs=4M if=$argv[2] of=/dev/r$argv[1] status=progress oflag=sync";
      mkdev.body = ''
        [[ -f .gitignore ]] && echo "\n" >> .gitignore
        cat ${../cfg/devshell/gitignore} >> .gitignore
        cat ${../cfg/devshell/shell.nix} >   shell.nix
        cat ${../cfg/devshell/flake.nix} >   flake.nix
        echo "use flake"                 >> .envrc
        direnv allow
      '';
      weiqi.body = ''
        argparse "h/help" "s/size=?!_validate_int --min 5 --max 52" "l/level=?!_validate_int --min 0 --max 10" -- $argv
        or return

        if set -ql _flag_help
          echo "Usage: weiqi [-h | --help] [-s | --size=NUM] [-l | --level=NUM] COLOUR"
          return
        end

        set colour "black"
        if set -ql argv[-1]; and test $argv[-1] = "black"
          set colour "white"
        end

        if set -ql _flag_size
          set size $_flag_size
        else
          set size 19
        end

        if set -ql _flag_level
          set level $_flag_level
        else
          set level 10
        end

        gogui -computer-$colour -size $size -program "gnugo --mode gtp --level $level"
      '';
    };
  };
}
