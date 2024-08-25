{ config, lib, pkgs, ... }:

{
  options = {
  };

  config = {
    programs.zsh = {
      enable = true;
    };

    home.file.".zshrc".source = ./.zshrc;
    home.file.".zshenv".source = ./.zshenv;
  };
}
