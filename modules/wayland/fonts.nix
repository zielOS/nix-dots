{ config, pkgs, ... }:

{
  fonts = {
    fontconfig = {
      subpixel = { 
        rgba = "rgb";
        lcdfilter = "default";
      };
      hinting = {
        enable = true;
        autohint = true;
        style = "hintfull";
      };
      antialias = true;
    };
    fonts = with pkgs; [
      fira-code
      fira-code-symbols
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
     ];
    enableDefaultFonts = false;
  };
}
