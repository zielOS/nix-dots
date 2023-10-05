{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wlogout
    yad
  ];

  xdg.configFile = {
    "wlogout/style.css".text = import ./style.nix;
    "wlogout/layout".text = import ./layout.nix;
  };
}
