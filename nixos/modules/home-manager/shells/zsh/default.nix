{ config, lib, pkgs, ... }:
let
  oh_my_posh_config_file = "oh-my-posh/config.toml";
in
{
  options = {
  };

  config = {
    home.packages = with pkgs; [
      oh-my-posh
    ];

    home.file."./.config/${oh_my_posh_config_file}" = {
      recursive = true;
      source = config.lib.meta.mk_out_of_store_symlink "./${oh_my_posh_config_file}";
    };

    programs.zsh = {
      enable = true;

      plugins = [
        {
          name = "zsh-256color";
          src = pkgs.fetchFromGitHub {
            owner = "chrissicool";
            repo = "zsh-256color";
            rev = "master";
            sha256 = "1fk84n29vi7ndxhmc8asxkwd2bhgacsimffqj2cw9c366aj5pyiz";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.8.0";
            sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
          };
        }
      ];

      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          #"zsh-256color"
          #"zsh-autosuggestions"
          #"zsh-syntax-highlighting"
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
        eval "$(oh-my-posh init zsh --config ./.config/${oh_my_posh_config_file})"
      '';
    };
  };
}
