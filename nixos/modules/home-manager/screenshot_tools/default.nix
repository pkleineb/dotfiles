{ pkgs, ... }: 

{
  home.packages = with pkgs; [
    satty
    slurp
    grim
  ];
}
