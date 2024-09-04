{ pkgs, config, ... }:

{
  home.packages = with pkgs; [
    dolphin
  ];

  home.file."./.config/dolphinrc".source = config.lib.meta.mk_out_of_store_symlink ./dolphinrc;
}
