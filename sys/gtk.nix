{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 36;
    };
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };
  };
}
