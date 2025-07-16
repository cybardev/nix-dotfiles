{ lib, ... }:
let
  # define custom colours here
  colours = {
    red = [
      "cb4335"
      "e6b0aa"
    ];
    green = [
      "606b56"
      "8a9a7b"
      "95a488"
      "b8c2af"
      "dbe0d7"
    ];
    blue = [
      "2e86c1"
      "85c1e9"
      "aed6f1"
    ];
    pink = [
      "bb7ebb"
      "ffbeff"
    ];
    teal = [
      "004347"
      "00cad0"
    ];
    sky = [
      "6b94ff"
      "94bbe9"
      "d0b3d5"
      "eeaeca"
    ];
  };
  mkColor =
    colors:
    {
      gradient = if lib.length colors > 1 then 1 else 0;
      gradient_count = lib.length colors;
    }
    // (lib.listToAttrs (
      lib.imap1 (i: v: {
        name = "gradient_color_${builtins.toString i}";
        value = "'#${v}'";
      }) colors
    ));
in
{
  programs.cava = {
    enable = true;
    settings = {
      general = {
        bars = 0;
        bar_width = 6;
        bar_spacing = 2;
      };
      color = mkColor colours.green; # set colour here
      output.method = "ncurses";
      smoothing.gravity = 42;
    };
  };
}
