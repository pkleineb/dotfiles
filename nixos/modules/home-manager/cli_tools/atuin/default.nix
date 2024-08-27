{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
  ];

  home.file."./.config/atuin/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./atuin;
  };
}
