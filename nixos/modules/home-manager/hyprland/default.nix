{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
  };

  home.file.".config/hypr/" = {
    recursive = true;
    source = ./hypr/;
  };
}
