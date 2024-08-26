{ config, ... }:

{
  programs.rofi = {
    enable = true;
  };

  home.file."./.config/rofi/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./rofi;
  };
}
