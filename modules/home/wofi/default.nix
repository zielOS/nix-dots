{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wofi
    wl-clipboard
    wtype
  ];

  xdg.configFile = {
    "wofi/colors".text = import ./colors.nix; 
    "wofi/style.css".text = import ./style.nix;
    "wofi/config".text = import ./config.nix;
  };
}
