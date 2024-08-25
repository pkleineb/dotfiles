{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wlogout
  ];

  home.file."./.config/wlogout/" = {
    recursive = true;
    source = ./wlogout;
  };
}
