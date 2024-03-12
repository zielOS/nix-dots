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
    ./foot
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    #./nvim
    ./starship
    ./gtk
    ./packages.nix
    ./zsh
    ./zathura
    inputs.hyprland.homeManagerModules.default
  ];
}
