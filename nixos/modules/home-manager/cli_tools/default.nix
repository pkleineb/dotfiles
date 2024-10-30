{ pkgs, ... }: 
{
  home.packages = with pkgs; [
    zoxide
    ripgrep
    fzf
    eza
    jq
    envsubst
    bat
    unzip
  ];

  services.playerctld = {
    enable = true;
  };
}
