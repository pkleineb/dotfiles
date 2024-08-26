{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gsettings
  ];
}
