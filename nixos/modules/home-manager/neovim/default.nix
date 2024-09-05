{ config, pkgs, ... }:
let
  treesitter_grammar = (pkgs.vimPlugins.nvim-treesitter.withPlugins (p: [
    p.rust
    p.html
    p.css
    p.javascript
    p.python
    p.kdl
    p.nix
  ]));

  treesitter-parsers = pkgs.symlinkJoin {
    name = "treesitter-parsers";
    paths = treesitter_grammar.dependencies;
  };

  local_path = ./.;
in
{
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    
    plugins = [
      treesitter_grammar
    ];

    extraPackages = with pkgs; [
      pylyzer
      python311Packages.jedi-language-server
      ruff-lsp
      rust-analyzer
      lua-language-server
      biome
      vscode-langservers-extracted
      vim-language-server
    ];
  };

  home.file."./dotfiles/nixos/modules/home-manager/neovim/nvim/lua/configs/treesitter_fix.lua".text = ''
  local M = {}

  function M.run()
    vim.opt.runtimepath:append("${treesitter-parsers}")
  end

  return M
  '';

  home.file."./.local/share/nvim/nix/nvim-treesitter/" = {
    recursive = true;
    source = treesitter_grammar;
  };

  home.file."./.config/nvim/" = {
    recursive = true;
    source = config.lib.meta.mk_out_of_store_symlink ./nvim;
  };
}
