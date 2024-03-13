{ pkgs, inputs, ... }:
{ 
  services.emacs = {
    enable = true;
    package = with pkgs; (
      (emacsPackagesFor emacs).emacsWithPackages (
        epkgs: with epkgs; [ use-package no-littering all-the-icons all-the-icons-dired cape consult corfu dashboard diminish dired-open peep-dired dired-sidebar dirvish drag-stuff eglot embark embark-consult evil evil-collection flycheck general git-timemachine magit hl-todo aggressive-indent markdown-mode marginalia doom-modeline nix-mode orderless org org-bullets pdf-tools projectile elpy rainbow-delimiters ob-async zmq company simple-httpd websocket jupyter rainbow-mode vterm vterm-toggle catppuccin tide ])
    );
    socketActivation.enable = true;
    defaultEditor = true;
    startWithUserSession = true;
  };
  home = {
    file.".config/emacs/init.el".source = ./init.el;
  };
}
