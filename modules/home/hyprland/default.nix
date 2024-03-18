{ inputs, pkgs, ... }:
let
  hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
  plugins = inputs.hyprland-plugins.packages.${pkgs.system};

  yt = pkgs.writeShellScript "yt" ''
    notify-send "Opening video" "$(wl-paste)"
    mpv "$(wl-paste)"
  '';

  playerctl = "${pkgs.playerctl}/bin/playerctl";
  brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
  pactl = "${pkgs.pulseaudio}/bin/pactl";
in
{
  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };


  home = { 
    packages = with pkgs; [ pyprland hyprshade hyprnome hypridle hyprlock ];
    file.".config/hypr/shaders/blue-light-filter.glsl".source  = ./blue-light-filter.glsl;
    file.".config/hypr/pyprland.json".source = ./pyprland.json;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland;
    systemd.enable = true;
    xwayland.enable = true;
    # plugins = with plugins; [ hyprbars borderspp ];

    settings = {
      exec-once = [
        "ags -b hypr"
        "hyprctl setcursor Qogir 24"
        "insync start"
        "ckb-next"
        "thunar --daemon"
      ];
        
      xwayland.force_zero_scaling = true;
      monitor = [
        "DP-3, 2560x1440@60, 0x0, 1"
        "DP-5, 2560x1440@60, 2560x0, 1"
      ];

      general = {
        layout = "dwindle";
        resize_on_border = true;
      };

      misc = {
	      disable_hyprland_logo = false;
	      disable_splash_rendering = true;
	      mouse_move_enables_dpms = false;
	      always_follow_on_dnd = true;
	      layers_hog_keyboard_focus = true;
	      animate_manual_resizes = true;
	      animate_mouse_windowdragging = true;
        disable_autoreload = false;
	      focus_on_activate = true;
	      no_direct_scanout = false;
        enable_swallow = true;
        vfr = false;
        vrr = false;
      };

      group = {
        groupbar = {
          font_size = 16;
          gradients = false;
        };
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          disable_while_typing = true;
          drag_lock = true;
        };
        sensitivity = 0;
        float_switch_override_focus = 2;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = false;
        preserve_split = true;
        force_split = 0;
        special_scale_factor = 0.97;
        split_width_multiplier = 1.0;
        no_gaps_when_only = false;
        use_active_for_splits = true;
        default_split_ratio = 1;
        # no_gaps_when_only = "yes";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_forever = true;
        workspace_swipe_numbered = true;
      };

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "org.gnome.Calculator")
        (f "org.gnome.Nautilus")
        (f "pavucontrol")
        (f "nm-connection-editor")
        (f "blueberry.py")
        (f "org.gnome.Settings")
        (f "org.gnome.design.Palette")
        (f "Color Picker")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gnome")
        (f "transmission-gtk")
        (f "com.github.Aylur.ags")
        "workspace 7, title:Spotify"
      ];

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvwindow = binding "SUPER SHIFT" "movewindow";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        e = "exec, ags -b hypr";
        arr = [1 2 3 4 5 6 7 8 9];
      in [
        "CTRL SHIFT, R,  ${e} quit; ags -b hypr"
        "SUPER, D,       ${e} -t applauncher"
        "SUPER, Tab,     ${e} -t overview"
        ",XF86PowerOff,  ${e} -r 'powermenu.shutdown()'"
        ",XF86Launch4,   ${e} -r 'recorder.start()'"
        ",Print,         ${e} -r 'recorder.screenshot()'"
        "SHIFT,Print,    ${e} -r 'recorder.screenshot(true)'"
        "SUPER, Return, exec, alacritty" # xterm is a symlink, not actually xterm
        "SUPER, B, exec, brave"
        "SUPER, T, exec, thunar"
        "SUPER, E, exec, emacsclient -c -a 'emacs'"

        # youtube
        ", XF86Launch1,  exec, ${yt}"

        "ALT, Tab, focuscurrentorlast"
        "CTRL ALT, Delete, exit"
        "SUPER, Q, killactive"
        "SUPER, F, togglefloating"
        "SUPER, G, fullscreen"
        "SUPER, O, fakefullscreen"
        "SUPER, P, togglesplit"
        "SUPER, X, exec, ags -b hypr -t powermenu"

        "CTRL_ALT, left, exec, hyprnome --previous"
        "CTRL_ALT, right, exec, hyprnome"
        "SUPER_CTRL_ALT, left, exec, hyprnome --previous --move"
        "SUPER_CTRL_ALT, right, exec, hyprnome --move"

        (mvfocus "up" "u")
        (mvfocus "down" "d")
        (mvfocus "right" "r")
        (mvfocus "left" "l")

        (resizeactive "k" "0 -20")
        (resizeactive "j" "0 20")
        (resizeactive "l" "20 0")
        (resizeactive "h" "-20 0")
        (mvwindow "up" "u")
        (mvwindow "down" "d")
        (mvwindow "right" "r")
        (mvwindow "left" "l")
      ]
      ++ (map (i: ws (toString i) (toString i)) arr)
      ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindle = [
        ",XF86MonBrightnessUp,   exec, ${brightnessctl} set +5%"
        ",XF86MonBrightnessDown, exec, ${brightnessctl} set  5%-"
        ",XF86KbdBrightnessUp,   exec, ${brightnessctl} -d asus::kbd_backlight set +1"
        ",XF86KbdBrightnessDown, exec, ${brightnessctl} -d asus::kbd_backlight set  1-"
        ",XF86AudioRaiseVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ +5%"
        ",XF86AudioLowerVolume,  exec, ${pactl} set-sink-volume @DEFAULT_SINK@ -5%"
      ];

      bindl =  [
        ",XF86AudioPlay,    exec, ${playerctl} play-pause"
        ",XF86AudioStop,    exec, ${playerctl} pause"
        ",XF86AudioPause,   exec, ${playerctl} pause"
        ",XF86AudioPrev,    exec, ${playerctl} previous"
        ",XF86AudioNext,    exec, ${playerctl} next"
        ",XF86AudioMicMute, exec, ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      decoration = {
        drop_shadow = "yes";
        shadow_range = 8;
        shadow_render_power = 2;
        "col.shadow" = "rgba(00000044)";

        dim_inactive = false;

        blur = {
          enabled = true;
          size = 8;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 4, myBezier"
          "windowsOut, 1, 4, default, popin 80%"
          "border, 1, 4, default"
          "fade, 1, 4, default"
          "workspaces, 1, 4, default"
        ];
      };

      plugin = {
        hyprbars = {
          bar_color = "rgb(2a2a2a)";
          bar_height = 28;
          col_text = "rgba(ffffffdd)";
          bar_text_size = 11;
          bar_text_font = "Ubuntu Nerd Font";

          buttons = {
            button_size = 0;
            "col.maximize" = "rgba(ffffff11)";
            "col.close" = "rgba(ff111133)";
          };
        };
      };
    };
  };
}
