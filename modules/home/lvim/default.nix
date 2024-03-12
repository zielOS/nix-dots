{ config, pkgs, ... }:

{ 
  home = { 
    packages = with pkgs; [ lunarvim neovim vimPlugins.nvim-treesitter ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}

