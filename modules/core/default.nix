{ config, pkgs, inputs, ...}:

{
  imports = [
    ./bootloader.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./network.nix
    ./python.nix
    #./gcc.nix
    #./modified.nix
    ./nix.nix
    ./polkit.nix
    ./system.nix
    ./users.nix
    ./zsh.nix
    ./hardening.nix
   ];
}
