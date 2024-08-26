{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
  ];

  home.file."./.config/dunst/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./dunst;
  };
}
