{
  home = {
    username = "ahsan";
    homeDirectory = "/home/ahsan";
    stateVersion = "23.11";
    extraOutputsToInstall = ["doc" "info" "devdoc"];
    sessionVariables = {
      TERMINAL = "alacritty";
      EDITOR = "nvim";
      BROWSER = "brave";
    };
  };

  imports = [
    ./alacritty
    #./anyrun
    ./ags_setup.nix
    ./dev.nix
    ./emacs
    ./git
    ./gtk 
    ./hyprland
    #./mako
    ./mpv
    ./nvim
    ./starship
    ./tools
    ./gtk
    ./texlive
/*     ./waybar */
    ./zsh
    ./zathura
  ];
}
