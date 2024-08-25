{ ... }:

{
  programs.zellij = {
    enable = true;
  };

  home.file."./.config/zellij/" = {
    recursive = true;
    source = ./zellij;
  };
}
