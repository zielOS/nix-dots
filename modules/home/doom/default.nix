{inputs, ...}: {
  imports = [ nix-doom-emacs.hmModule ];

  programs.doom-emacs = {
    enable = true;
  };
}
