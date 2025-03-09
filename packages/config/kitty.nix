{ ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "Doom_Vibrant";
    settings = {
      shell = "zsh";
      font_family = "CaskaydiaCove Nerd Font Mono";
      font_size = 14;
      enable_audio_bell = false;
      tab_bar_edge = "top";
      background_opacity = 0.96;
    };
  };

  # Custom Icon
  # License: MIT Copyright: 2024, Andrew Haust <https://github.com/sodapopcan/kitty-icon>
  home.file.".config/kitty/kitty.app.png".source = ./kitty.app.png;
}
