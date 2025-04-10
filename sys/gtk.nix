{ pkgs }:
{
  gtk = {
    enable = true;
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
    cursorTheme = {
      name = "Qogir-manjaro-dark";
      package = pkgs.qogir-icon-theme;
      size = 64;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };
}
