{ config, ... }:

{
  programs.waybar = {
    enable = true;
  };

  home.file."./.config/waybar/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./waybar;
  };
}
