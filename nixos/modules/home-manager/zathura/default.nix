{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
  };

  home.packages = with pkgs; [
    texliveFull
  ];
}
