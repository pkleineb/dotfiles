{ config, lib, pkgs, ... }:

{
  options = {
  };

  config = {
    programs.zsh = {
      enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "zsh-256color"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
        ];
      };

      shellAliases = {
        # list aliases
        l = "eza -lh  --icons=auto"; # long list
        ls = "eza -1   --icons=auto"; # short list
        ll = "eza -lha --icons=auto --sort=name --group-directories-first"; # long list all
        ld = "eza -lhD --icons=auto"; # long list dirs

        # shorthands
        nv = "nvim";
        lg = "lazygit";
        sysstart = "sudo systemctl start";
        sysstop = "sudo systemctl stop";
        sysrestart = "sudo systemctl restart";

        # Handy change dir shortcuts
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";

        # Always mkdir a path (this doesn"t inhibit functionality to make a single dir)
        mkdir = "mkdir -p";
      };

      initExtra = ''
        eval "$(atuin init zsh)"
        eval "$(zoxide init zsh)"
      '';
    };

    #home.file.".zshrc".source = config.lib.meta.mk_out_of_store_symlink ./.zshrc;
    #home.file.".zshenv".source = config.lib.meta.mk_out_of_store_symlink ./.zshenv;
  };
}
