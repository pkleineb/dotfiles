{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  home.file."./.config/swww/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./swww;
  };
}
