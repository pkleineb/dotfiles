{ pkgs, ... }:
let
  themes = let themes = pkgs.libsForQt5.callPackage ./sddm-themes.nix {}; in [
    themes.corners
  ];
  qt_pkgs = with pkgs.libsForQt5.qt5; [
    qtgraphicaleffects
    qtsvg
    qtquickcontrols
  ];
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };

    theme = "corners";
  };

  environment.systemPackages = themes ++ qt_pkgs;
}
