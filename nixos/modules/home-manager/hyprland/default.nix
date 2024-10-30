{ config, pkgs, ... }:

{
  home.file."./.config/hypr/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./hypr;
  };

  home.packages = with pkgs; [
    glib
    cliphist
    wl-clipboard
  ];
}
