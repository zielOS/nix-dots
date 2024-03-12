{ pkgs, ... }:
{ 
  services.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (
        epkgs: with epkgs; [ use-package no-littering all-the-icons all-the-icons-dired cape consult corfu dashboard diminish dired-open peep-dired dired-sidebar dirvish drag-stuff eglot embark embark-consult evil evil-collection flycheck general git-timemachine magit hl-todo aggressive-indent ])
    );
  };
}
