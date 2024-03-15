{ inputs, pkgs, config, self, ...}:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  home.packages = with pkgs; [
    alacritty
    insync
    python311Packages.jupyter
    kitty
    lutris
    brave
    fastfetch
    pyprland
    hyprshade
    hyprnome
    lsd
    git
    cached-nix-shell 
    typescript
    fzf
    nodejs
    spotify
    gjs
    bun
    cargo
    lynis
    unzip
    ripgrep
    ffmpeg
    pymol
    xournalpp
    imagemagick
    deluge
    fd
    jq 
    lm_sensors
    catppuccin-gtk
  ];
}
