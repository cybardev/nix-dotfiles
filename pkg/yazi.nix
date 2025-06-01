{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "fm";
    plugins = with pkgs.yaziPlugins; {
      inherit
        relative-motions
        full-border
        yatline
        git
        ;
    };
    settings = {
      manager = {
        sort_by = "extension";
        sort_dir_first = true;
      };
      opener.text = [
        {
          run = "$EDITOR '$@'";
          block = true;
          for = "unix";
        }
      ];
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
    flavors = {
      onedark = pkgs.fetchFromGitHub {
        owner = "BennyOe";
        repo = "onedark.yazi";
        rev = "668d71d967857392012684c7dd111605cfa36d1a";
        hash = "sha256-tfkzVa+UdUVKF2DS1awEusfoJEjJh40Bx1cREPtewR0=";
      };
    };
    theme = {
      flavor.dark = "onedark";
      manager.border_style.fg = "#ABB2BF";
    };
    initLua = ../cfg/yazi.lua;
    keymap = {
      manager.prepend_keymap = [
        {
          run = "plugin relative-motions 1";
          on = [ "1" ];
        }
        {
          run = "plugin relative-motions 2";
          on = [ "2" ];
        }
        {
          run = "plugin relative-motions 3";
          on = [ "3" ];
        }
        {
          run = "plugin relative-motions 4";
          on = [ "4" ];
        }
        {
          run = "plugin relative-motions 5";
          on = [ "5" ];
        }
        {
          run = "plugin relative-motions 6";
          on = [ "6" ];
        }
        {
          run = "plugin relative-motions 7";
          on = [ "7" ];
        }
        {
          run = "plugin relative-motions 8";
          on = [ "8" ];
        }
        {
          run = "plugin relative-motions 9";
          on = [ "9" ];
        }
      ];
    };
  };
}
