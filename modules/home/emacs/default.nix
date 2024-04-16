{ pkgs, inputs, ... }:
{ 
  programs.emacs = {
    enable = true;
    package = pkgs.emacs29-pgtk;
    # extraPackages = epkgs: with epkgs; [ no-littering all-the-icons all-the-icons-dired cape consult corfu dashboard diminish dired-open peep-dired dired-sidebar dirvish drag-stuff eglot embark embark-consult evil evil-collection flycheck general git-timemachine hl-todo aggressive-indent markdown-mode marginalia doom-modeline nix-mode orderless org org-bullets pdf-tools projectile elpy rainbow-delimiters rainbow-mode vterm vterm-toggle catppuccin-theme tide vertico which-key zmq simple-httpd websocket use-package jupyter ob-async
    # 
    # ];

  };

  # home.file.".emacs.d/init.el".source = ./init.el;
  # home.file.".emacs.d/art/".source = ./art;

  services.emacs = {
    enable = false;
    package = pkgs.emacs29-pgtk;
  };
}
