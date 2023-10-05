{ config, pkgs, ... }:

{
  services.mako = {
    enable = true;
    width = 600;
    height = 300;
    margin = "10";
    padding = "15";
    borderSize = 2;
    borderRadius = 5;
    iconPath = "./icons";
    markup = true;
    maxVisible = 5;
    layer = "overlay";
    anchor = "top-right";
    backgroundColor = "#1e1e2e";
    textColor = "#d9e0ee";
    borderColor = "#313244";
    progressColor = "over #89b4fa";

    extraConfig = "
      [urgency=low]
      border-col      or=#313244
      default-timeout=2000

      [urgency=normal]
      border-color=#313244
      default-timeout=5000

      [urgency=high ]
      border-color=#f38ba8
      text-color=#f38ba8
      default-timeout=0
           ";
      };
    }
