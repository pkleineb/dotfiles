{ pkgs, ... }:

{
  home.packages = with pkgs; [
    atuin
  ];

  home.file.".config/atuin/" = {
    recursive = true;
    source = ./atuin/;
  };
}
