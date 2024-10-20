{ config, lib, pkgs, inputs, ... }:
let
  pointer_name = "Bibata-Modern-Ice";
  pointer_size = 20;
  pointer_package = pkgs.bibata-cursors;

  pointer = {
    name = pointer_name;
    size = pointer_size;
    package = pointer_package;
  };
in
{
  imports = inputs.self.outputs.scripts.import_all_modules { lib=lib; dir=./../../modules/home-manager; };
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.pointerCursor = pointer // {
    x11.enable = true;
    gtk.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };

    cursorTheme = pointer;
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.qt5ct
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.05"; # DO NOT CHANGE.


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
