{ inputs, pkgs, config, self, ...}:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  home.packages = with pkgs; [
    cached-nix-shell 
    fzf
    lynis
    unzip
    ripgrep
    ffmpeg
    pymol
    xournalpp
    p3x-onenote
    rclone
    rclone-browser
    emacsPgtk
    imagemagick
    evince
    transmission-gtk
    fd
    jq 
    lm_sensors
    self.packages.${pkgs.system}.onlyoffice-deb 
  ];
}
