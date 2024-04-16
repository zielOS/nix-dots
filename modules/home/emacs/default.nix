{inputs, pkgs, ...}: {
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
    doomPrivateDire = ./doom.d/
    emacsPackage = pkgs.emacs-pgtk;
  };

  services.emacs = {
    enable = false;
  };
}
