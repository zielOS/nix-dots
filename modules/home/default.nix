{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
  };

  imports = [
    ./ags_setup.nix
    ./dev.nix
    ./emacs
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    ./lvim
    ./starship
    ./gtk
    #./packages.nix
    ./zsh
    ./zathura
  ];
}
