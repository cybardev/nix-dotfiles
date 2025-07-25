{
  config,
  pkgs,
  lib,
  ...
}:
{
  programs = {
    fish = {
      enable = true;
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
        etch.body = "sudo dd bs=4M if=$argv[2] of=/dev/$argv[1] status=progress oflag=sync";
        mkdev.body = ''
          [[ -f .gitignore ]] && echo "\n" >> .gitignore
          cat ${../cfg/devshell/gitignore} >> .gitignore
          cat ${../cfg/devshell/shell.nix} >   shell.nix
          cat ${../cfg/devshell/flake.nix} >   flake.nix
          echo "use flake"                 >> .envrc
          direnv allow
        '';
      };
    };
    starship = {
      enable = config.programs.fish.enable;
      enableZshIntegration = false;
      settings = {
        add_newline = false;
        cmd_duration = {
          format = "[$duration]($style) ";
          min_time = 5000;
        };
        character = {
          success_symbol = "[\\(λ\\)](bold #ff77cc)";
          error_symbol = "[\\(λ\\)](bold #ee7777)";
          vicmd_symbol = "[<λ>](bold #ff77cc)";
        };
        directory = {
          truncation_length = 1;
          style = "bold #44ccff";
          format = "[$path]($style)[$read_only]($read_only_style) ";
        };
        git_branch.format = "[<$branch(:$remote_branch)>]($style) ";
        status = {
          disabled = false;
          format = "[\\[$status\\] ]($style)";
        };
        format = lib.concatStrings [
          "$status"
          "$character"
        ];
        right_format = lib.concatStrings [
          "$cmd_duration"
          "$git_status"
          "$git_branch"
          "$directory"
        ];
      };
    };
  };
}
