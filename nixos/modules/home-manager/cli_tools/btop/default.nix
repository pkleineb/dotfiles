{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.btop
  ];

  home.file."./.config/btop/" = {
    recursive = true;
    source = ./btop;
  };
}
