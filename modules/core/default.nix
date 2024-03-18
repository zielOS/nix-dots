{ config, pkgs, inputs, ...}:

{
  imports = [
    ./bootloader.nix
    ./bluetooth.nix
    ./flatpak.nix
    ./network.nix
    ./elfutils.nix
    ./packages.nix
    ./nix.nix
    ./polkit.nix
    ./system.nix
    ./users.nix
    ./zsh.nix
    ./hardening.nix
   ];
}
