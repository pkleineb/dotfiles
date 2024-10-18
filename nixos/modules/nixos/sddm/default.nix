{ pkgs, ... }:

{
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
    };

    theme = "corners";
  };

  environment.systemPackages = let themes = pkgs.callPackage ./sddm-themes.nix {}; in [
    themes.corners
  ];
}
