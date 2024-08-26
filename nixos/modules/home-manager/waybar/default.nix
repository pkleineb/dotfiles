{ ... }:

{
  programs.waybar = {
    enable = true;
  };

  home.file."./.config/waybar/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./waybar;
  };
}
