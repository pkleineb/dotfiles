{ pkgs, ... }:

pkgs.writeShellScriptBin "custom_chsh" ''
  exec ${pkgs.util-linux}/bin/chsh --shell-file $HOME/.config/shells "$@"
'';
