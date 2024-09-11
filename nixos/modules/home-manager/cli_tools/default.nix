{ pkgs, ... }: 
{
  home.packages = with pkgs; [
    zoxide
    ripgrep
    fzf
    eza
    jq
    bat
    wl-clipboard-rs
  ];

  services.playerctld = {
    enable = true;
  };
}
