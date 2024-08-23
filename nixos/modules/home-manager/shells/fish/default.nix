{ lib, pkgs, config, ... }:

{
  options = {
    fish.default_shell = lib.mkEnableOption "set fish as default shell in .bashprofile";
  };

  config = {
    programs.fish = {
      enable = true;
    };

    home.file.".bashprofile".text = lib.mkIf config.zsh.default_shell(lib.mkDefault(
      lib.mkBefore ''
        exec fish
      ''
    ));
  };
}
