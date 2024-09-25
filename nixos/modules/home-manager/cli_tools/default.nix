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
    wl-clipboard-rs
    unzip
  ];

  services.playerctld = {
    enable = true;
  };
}
