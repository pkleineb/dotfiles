{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    swww
  ];

  home.file."./.config/swww/" = {
    recursive = true;
    source =  config.lib.meta.mk_out_of_store_symlink ./swww;
  };
}
