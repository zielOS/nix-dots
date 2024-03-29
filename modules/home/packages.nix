{ inputs, pkgs, config, self, ...}:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  home.packages = with pkgs; [
    element-desktop
    alacritty
    insync
    kitty
    lutris
    brave
    fastfetch
    lsd
    git
    cached-nix-shell 
    typescript
    fzf
    nodejs
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
