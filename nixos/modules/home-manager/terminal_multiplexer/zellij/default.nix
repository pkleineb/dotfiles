{ config, ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file."./.config/zellij/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./zellij;
  };
}
