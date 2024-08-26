{ ... }:

{
  programs.zellij = {
    enable = true;
  };

  home.file."./.config/zellij/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./zellij;
  };
}
