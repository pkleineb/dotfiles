{ config, lib, pkgs, ... }:

{
  options = {
  };

  config = {
    programs.zsh = {
      enable = true;
    };

    home.file.".zshrc".source = config.lib.meta.mk_out_of_store_symlink ./.zshrc;
    home.file.".zshenv".source = config.lib.meta.mk_out_of_store_symlink ./.zshenv;
  };
}
