{ config, pkgs, ... }:

{ 
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  home = { 
    packages = with pkgs; [ lunarvim vimPlugins.nvim-treesitter ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}

