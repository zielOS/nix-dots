{ inputs, pkgs, config, lib, self,...}:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./ags_setup.nix
    #./doom
    ./foot
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    ./lvim
    ./starship
    ./gtk
    ./packages.nix
    ./zsh
    ./zathura
    inputs.hyprland.homeManagerModules.default
  ];
}
