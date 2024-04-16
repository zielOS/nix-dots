{ config, pkgs, ...}:
{
  services.flatpak.enable = true;
  xdg.portal.config.common.default = [ "gtk" ];
}
