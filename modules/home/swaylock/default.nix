{ pkgs, lib, config, inputs, ... }:

{
  home.packages = with pkgs; [swaylock-effects];
  
  programs.swaylock = {
    settings = {
      clock = true;
      color = "303446"; 
      font = "JetBrainsMono Nerd Font";
      font-size = 24;
      show-failed-attempts = false;
      indicator = true;
      indicator-radius = 200;
      indicator-thickness = 20;
      line-color = "303446";
      ring-color = "626880";
      inside-color = "303446";
      key-hl-color = "eebebe";
      separator-color = "00000000";
      text-color = "c6d0f5";
      text-caps-lock-color = "";
      line-ver-color = "eebebe";
      ring-ver-color = "eebebe";
      inside-ver-color = "303446";
      text-ver-color = "c6d0f5";
      ring-wrong-color = "e78284";
      text-wrong-color = "e78284";
      inside-wrong-color = "303446";
      inside-clear-color = "303446";
      text-clear-color = "c6d0f5";
      ring-clear-color = "a6d189";
      line-clear-color = "303446";
      line-wrong-color = "303446";
      bs-hl-color = "e78284";
      line-uses-ring = false;
      grace = 2;
      grace-no-mouse = true;
      grace-no-touch = true;
      datestr = "%d.%m";
      timestr = "%I:%M %p";
      fade-in = "0.1";
      ignore-empty-password = true;
    };
  };

  services.swayidle = {
    enable = true;
    events = [
      {
        event = "before-sleep";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
      {
        event = "lock";
        command = "${pkgs.swaylock-effects}/bin/swaylock -fF";
      }
    ];
    timeouts = [
      {
        timeout = 3000;
        command = "${pkgs.systemd}/bin/loginctl lock-session";
      }
      {
        timeout = 3000;
        command = "${pkgs.systemd}/bin/systemctl hibernate";
      }     
    ];
  };

  systemd.user.services.swayidle.Install.WantedBy = lib.mkForce ["hyprland-session.target"];
}
