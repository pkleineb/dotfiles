{ pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  home.file."./.config/swww/" = {
    recursive = true;
    source = ./swww;
  };
}
