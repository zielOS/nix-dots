{ config, pkgs, ... }:

{
  home = { 
    packages = with pkgs; [ neovim lunarvim ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}
