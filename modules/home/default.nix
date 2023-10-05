{ inputs, pkgs, config, lib, self,...}:

{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "22.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./avizo
    ./eww
    ./firefox
    ./foot
    ./git
    ./gtk 
    ./hyprland
    ./mako
    ./mpv
    #./nvim
    ./scripts
    ./packages.nix
    ./shell
    ./swaylock
    ./tools
    ./waybar
    ./wlogout
    ./wofi
    ./zathura
    inputs.hyprland.homeManagerModules.default
  ];
}
