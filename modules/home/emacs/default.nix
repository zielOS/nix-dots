{ pkgs, ... }:
{ 
  services.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (
        epkgs: [epkgs.use-package epkgs.no-littering epkgs.all-the-icons epkgs.all-the-icons-dired
              epkgs.cape
              epkgs.consult
              epkgs.corfu
              epkgs.dashboard
              epkgs.diminish
              epkgs.dired-open
              epkgs.peep-dired
              epkgs.dired-sidebar
              epkgs.dirvish
              epkgs.drag-stuff
              epkgs.eglot
              epkgs.embark
              epkgs.embark-consult
              epkgs.evil
              epkgs.evil-collection
              epkgs.flycheck
              epkgs.general
              epkgs.git-timemachine
              epkgs.magit
              epkgs.hl-todo
              epkgs.aggressive-indent ])
    );
  };
}
