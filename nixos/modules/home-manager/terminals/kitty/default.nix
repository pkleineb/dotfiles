{ config, lib, pkgs, ... }:

{
  home.packages = [
    pkgs.kitty
  ];

  home.file."./.config/kitty/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./kitty;
  };
}
