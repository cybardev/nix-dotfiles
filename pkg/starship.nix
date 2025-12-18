{ lib, ... }:
{
  programs.starship = {
    enable = true;
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
}
