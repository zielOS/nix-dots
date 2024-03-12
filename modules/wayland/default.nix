{ config, pkgs, inputs, ... }: 

{
  imports = [
    ./fonts.nix 
    ./services.nix
  ];
  
  nixpkgs.overlays = with inputs; [nixpkgs-wayland.overlay];
  environment.etc."greetd/environments".text = ''
    Hyprland
  '';

  environment = {
    variables = {
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      ANKI_WAYLAND = "1";
      DIRENV_LOG_FORMAT = "";
      DISABLE_QT5_COMPAT = "0";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      GDK_DPI_SCALE = "1.7";
      GDK_SCALE = "1.8";
      MOZ_ENABLE_WAYLAND = "1";
      QT_FONT_DPI = "120 clementine";
      QT_QPA_PLATFORM = "xcb";
      QT_SCALE_FACTOR = "1.7";
      QT_WAYLAND_DISABLE_WINDOWDEROCATION = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      XDG_SESSION_DESKTOP = "hyprland";
      XDG_CURRENT_DESKTOP = "hyprland";
      XDG_CURRENT_SESSION = "hyprland";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      WLR_DRM_NO_ATOMIC = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      WLR_NO_HARDWARE_CURSORS = "1";

    };
    loginShellInit = ''
      dbus-update-activation-environment --systemd DISPLAY
      eval $(gnome-keyring-daemon --start --components=ssh)
    '';
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        xwayland
      ];
    };
    ckb-next.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      inputs.xdg-portal-hyprland.packages.${pkgs.system}.default
    ];
  };

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

}
