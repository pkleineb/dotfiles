{ config, ... }:

{
  home.file."./.config/hypr/" = {
    recursive = true;
    source = ./hypr;
    text = ''
      source = ${config.home.homeDirectory}/animations.conf
      source = ${config.home.homeDirectory}/keybindings.conf
      source = ${config.home.homeDirectory}/windowrules.conf
      source = ${config.home.homeDirectory}/themes/common.conf # shared theme settings
      source = ${config.home.homeDirectory}/themes/theme.conf # theme specific settings
      source = ${config.home.homeDirectory}/themes/colors.conf # wallbash color override
      source = ${config.home.homeDirectory}/monitors.conf # initially empty, to be configured by user and remains static
      source = ${config.home.homeDirectory}/userprefs.conf # initially empty, to be configured by user and remains static
    '';
  };
}
