{ pkgs, inputs, ... }: 
let
  import_dirs = inputs.self.outputs.scripts.import_all_modules;
in
{
  imports = import_dirs { dir=./.; };

  home.packages = with pkgs; [
    zoxide
    ripgrep
    fzf
    eza
    jq
  ];

  services.playerctld = {
    enable = true;
  };
}
