{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    pkgs.btop
  ];

  home.file."./.config/btop/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./btop;
  };
}
