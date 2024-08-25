{ ... }:

{
  programs.git = {
    enable = true;
  };

  home.file."./.config/git/" = {
    recursive = true;
    source = ./git;
  };
}
