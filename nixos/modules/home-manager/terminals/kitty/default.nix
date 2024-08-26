{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.kitty
  ];

  home.file."./.config/kitty/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./kitty;
  };
}
