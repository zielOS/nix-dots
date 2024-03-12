{ config, nixpkgs, nix-doom-emacs, .. }:

{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;

  };


}
