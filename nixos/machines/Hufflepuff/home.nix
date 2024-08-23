{ config, lib, pkgs, inputs, ... }:
let
  home_modules = import ./../../modules/home-manager { inherit pkgs inputs; };
in
{
  imports = [
    ../../modules/home-manager
  ];

  home.username = "paul";
  home.homeDirectory = "/home/paul";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
  ];

  programs.git.enable = true;

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
    LD_LIBRARY_PATH = "${pkgs.libGL}/lib/:${pkgs.stdenv.cc.cc.lib}/lib/";
  };

  home.stateVersion = "24.05"; # DO NOT CHANGE.


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
