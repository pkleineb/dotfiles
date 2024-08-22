{ pkgs, ... }:

{
  home.packages = with pkgs; [
    stow;
  ];
}
