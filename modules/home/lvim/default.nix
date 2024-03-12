{ config, pkgs, ... }:

{ 
  home = { 
    packages = with pkgs; [ lunarvim neovim ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}

