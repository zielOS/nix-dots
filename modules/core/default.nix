{ config, pkgs, inputs, ...}:

{
  imports = [
    ./bootloader.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./network.nix
    #./python.nix
    ./packages.nix
    #./cuda.nix
    ./gcc.nix
    ./modified.nix
    ./nix.nix
    ./polkit.nix
    ./system.nix
    ./users.nix
    ./zsh.nix
    ./hardening.nix
   ];
}
