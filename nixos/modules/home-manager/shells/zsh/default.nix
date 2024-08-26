{ config, lib, pkgs, ... }:

{
  options = {
  };

  config = {
    programs.zsh = {
      enable = true;
    };

    home.file.".zshrc".source = config.lib.file.mkOutOfStoreSymlink ./.zshrc;
    home.file.".zshenv".source = config.lib.file.mkOutOfStoreSymlink ./.zshenv;
  };
}
