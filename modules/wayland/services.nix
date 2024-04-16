{ config, pkgs, inputs, ... }:

{
  systemd.services = {
    seatd = {
      enable = true;
      description = "Seat management daemon";
      script = "${pkgs.seatd}/bin/seatd -g wheel";
      serviceConfig = {
        Type = "simple";
        Restart = "always";
        RestartSec = "1";
      };
      wantedBy = ["multi-user.target"];
    };
  };


  services = {
    greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "Hyprland";
          user = "ahsan";
        };
        default_session = initial_session;
      };
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    acpid.enable = true;
    thermald.enable = true;
    upower.enable = true;
    udisks2.enable = true;
    fstrim.enable = true;

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      wireplumber.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
