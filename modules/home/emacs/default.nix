{ pkgs, inputs, ... }:
{ 
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [ epkgs.no-littering epkgs.all-the-icons epkgs.all-the-icons-dired epkgs.cape epkgs.consult epkgs.corfu epkgs.dashboard epkgs.diminish epkgs.dired-open epkgs.peep-dired epkgs.dired-sidebar epkgs.dirvish epkgs.drag-stuff epkgs.eglot epkgs.embark epkgs.embark-consult epkgs.evil epkgs.evil-collection epkgs.flycheck epkgs.general epkgs.git-timemachine epkgs.hl-todo epkgs.aggressive-indent epkgs.jupyter epkgs.ob-async epkgs.markdown-mode epkgs.marginalia epkgs.doom-modeline epkgs.nix-mode epkgs.orderless epkgs.org epkgs.org-bullets epkgs.pdf-tools epkgs.projectile epkgs.elpy epkgs.rainbow-delimiters epkgs.rainbow-mode epkgs.vterm epkgs.vterm-toggle epkgs.catppuccin-theme epkgs.tide epkgs.vertico epkgs.which-key epkgs.zmq epkgs.simple-httpd epkgs.websocket
    ];

  };

home.file.".emacs.d".source = ./.;

  services.emacs = {
    enable = true; 
    defaultEditor = true;
  };
}
