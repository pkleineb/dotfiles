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
    users.users.${user_config.user_name} = {
      isNormalUser = true;
      initialPassword = "12345";
      description = "main user";
      shell = pkgs.bash;
      extraGroups = [ "wheel" ];
    };
  };
}
