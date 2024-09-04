{ lib, config, pkgs, ... }:

let
  user_config = config.main-user;
in
{
  options.main-user = {
    enable = lib.mkEnableOption "enable user module";

    user_name = lib.mkOption {
      default = "default";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf user_config.enable {
    programs.zsh = {
      enable = true;
    };

    users.users.${user_config.user_name} = {
      isNormalUser = true;
      shell = pkgs.zsh;
      initialPassword = "12345";
      description = ${user_config.user_name};
      extraGroups = [ "wheel" ];
    };

    environment.sessionVariables = {
      SHELL = pkgs.zsh;
    };
  };
}
