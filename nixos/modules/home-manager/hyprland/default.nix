{ config, ... }:

{
  home.file."./.config/hypr/" = {
    recursive = true;
    source = config.lib.file.mkOutOfStoreSymlink ./hypr;
  };
}
