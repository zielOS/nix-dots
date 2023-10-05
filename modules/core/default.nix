{ config, pkgs, inputs, ...}:

{
  imports = [
    ./bootloader.nix
    ./flatpak.nix
    ./hardening.nix
    ./network.nix
    ./nix.nix
    ./polkit.nix
    ./system.nix
    ./users.nix
  ];
}
