{ pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "fm";
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
    };
    plugins = {
      relative-motions = pkgs.fetchFromGitHub {
        owner = "dedukun";
        repo = "relative-motions.yazi";
        rev = "4244639d480e797a43d6514ddee021a0cb6d1cd6";
        hash = "sha256-83cTNxGbPzzWEGTwkpf/WweHuKJSAPIGLf4DzY9vqog=";
      };
    };
    initLua = ''
      require("relative-motions"):setup({ show_numbers="relative_absolute", show_motion = true })
    '';
    keymap = {
      manager.prepend_keymap = [
        {
          run = "plugin relative-motions --args=1";
          on = [ "1" ];
        }
        {
          run = "plugin relative-motions --args=2";
          on = [ "2" ];
        }
        {
          run = "plugin relative-motions --args=3";
          on = [ "3" ];
        }
        {
          run = "plugin relative-motions --args=4";
          on = [ "4" ];
        }
        {
          run = "plugin relative-motions --args=5";
          on = [ "5" ];
        }
        {
          run = "plugin relative-motions --args=6";
          on = [ "6" ];
        }
        {
          run = "plugin relative-motions --args=7";
          on = [ "7" ];
        }
        {
          run = "plugin relative-motions --args=8";
          on = [ "8" ];
        }
        {
          run = "plugin relative-motions --args=9";
          on = [ "9" ];
        }
      ];
    };
  };
}
