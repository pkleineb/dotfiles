{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.btop
  ];

  home.file."./.config/btop/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./btop;
  };
}
