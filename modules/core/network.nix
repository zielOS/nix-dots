{ config, pkgs, lib, ...}:

{
  networking = {
    # dns
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      wifi.macAddress = "random";
    };
    firewall = {
      enable = true;
      allowPing = false;
      logReversePathDrops = true;
    };
  };


  programs = {
    nm-applet.enable = true;
  };

  services = {
    gnome.glib-networking.enable = true;
    resolved.enable = true;
  };

  systemd.services.NetworkManager-wait-online.enable = false;
}
