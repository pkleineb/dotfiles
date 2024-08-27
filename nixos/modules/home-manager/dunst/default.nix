{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dunst
  ];

  home.file."./.config/dunst/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./dunst;
  };
}
