{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    rofi-wayland
  ];

  home.file."./.config/rofi/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./rofi;
  };
}
