{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./alacritty
/*     ./ags_setup.nix */
    ./dev.nix
    ./emacs
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    ./lvim
    ./starship
    ./tools
    ./gtk
    ./texlive.nix
    ./waybar
    ./zsh
    ./zathura
  ];
}
