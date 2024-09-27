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
    direnv
  ];

  services.playerctld = {
    enable = true;
  };
}
