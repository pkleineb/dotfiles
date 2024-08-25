{ ... }:

{
  programs.waybar = {
    enable = true;
  };

  home.file.".config/waybar/" = {
    recursive = true;
    source = ./waybar/;
  };
}
