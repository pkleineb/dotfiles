{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
  ];

  home.file."./.config/atuin/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./atuin;
  };
}
