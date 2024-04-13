{ config, pkgs, ... }:

{ 
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];
  };
  home = { 
    packages = with pkgs; [ lunarvim vimPlugins.nvim-treesitter ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}

