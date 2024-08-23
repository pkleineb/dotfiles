{ config, lib, pkgs, ... }:

{
  options = {
    zsh.default_shell = lib.mkEnableOption "set zsh as default shell in .bashprofile";
  };

  config = {
    programs.zsh = {
      enable = true;
    };

    home.file.".bashprofile".text = lib.mkIf config.zsh.default_shell(lib.mkDefault(
      lib.mkBefore ''
        exec zsh
      ''
    ));

    home.file.".zshrc".source = ./.zshrc;
    home.file.".zshenv".source = ./.zshenv;
  };
}
