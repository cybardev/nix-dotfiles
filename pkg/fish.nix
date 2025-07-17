{ pkgs, lib, ... }:
{
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
      functions = {
        fm = {
          body = "cd \"$(${lib.getExe pkgs.lf} -print-last-dir \"$argv\")\"";
        };
        # fan = "f() { du -hd1 \"$1\" | sort -hr }; f";
        # unly = "f() { curl -Is \"$1\" | grep ^location | cut -d \" \" -f 2 }; f";
        # etch = "f() { sudo dd bs=4M if=$2 of=/dev/$1 status=progress oflag=sync }; f";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = false;
      settings = {
        add_newline = false;
        cmd_duration.format = "[$duration]($style) ";
        character = {
          success_symbol = "[\\(λ\\)](bold purple)";
          error_symbol = "[\\(λ\\)](bold red)";
          vicmd_symbol = "[<λ>](bold cyan)";
        };
        directory = {
          truncation_length = 1;
          style = "bold bright-cyan";
          format = "[$path]($style)[$read_only]($read_only_style)";
        };
        git_branch.format = "[$branch(:$remote_branch)]($style) ";
        format = "$character";
        right_format = lib.concatStrings [
          "$cmd_duration"
          "$git_status"
          "$git_branch"
          "$nix_shell"
          "$direnv"
          "$directory"
        ];
        nodejs.disabled = true;
        time.disabled = true;
      };
    };
  };
}
