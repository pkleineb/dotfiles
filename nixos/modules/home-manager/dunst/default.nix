{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
  ];

  home.file."./.config/dunst/" = {
    recursive = true;
    source = ./dunst;
  };
}
