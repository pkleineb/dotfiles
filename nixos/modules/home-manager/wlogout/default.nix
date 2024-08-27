{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wlogout
  ];

  home.file."./.config/wlogout/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./wlogout;
  };
}
