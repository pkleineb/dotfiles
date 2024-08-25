{ ... }:

{
  programs.rofi = {
    enable = true;
  };

  home.file.".config/rofi/" = {
    recursive = true;
    source = ./rofi/;
  };
}
