{ pkgs, lib, config, inputs, ... }:

with lib;

let
  hyprlogout = pkgs.writeShellScriptBin "hyprlogout" ''
    #!/usr/bin/env bash
    LAYOUT=$HOME/.config/wlogout/layout
    STYLE=$HOME/.config/wlogout/style.css

    if [[ ! `pidof wlogout` ]]; then
      wlogout --layout $LAYOUT --css $STYLE \
        --buttons-per-row 5 \
        --column-spacing 50 \
        --row-spacing 50 \
        --margin-top 390 \
        --margin-bottom 390 \
        --margin-left 150 \
        --margin-right 150
    else
      pkill wlogout
    fi
  '';
  

  hyprmenu = pkgs.writeShellScriptBin "hyprmenu" ''
    #!/usr/bin/env bash 
    CONFIG=$HOME/.config/wofi/config
    STYLE=$HOME/.config/wofi/style.css
    COLORS=$HOME/.config/wofi/colors

    if [[ ! `pidof wofi` ]]; then
      wofi --show drun --prompt 'Search...' --conf $CONFIG --style $STYLE --color $COLORS
    else
      pkill wofi
    fi
  '';

  hyprterminal = pkgs.writeShellScriptBin "hyprterminal" ''
    #!/usr/bin/env bash
    CONFIG=$HOME/.config/foot/foot.ini

    if [ "$1" == "-f" ]; then
      foot --app-id='foot-float' --config="$CONFIG"
    elif [ "$1" == "-F" ]; then
      foot --fullscreen --app-id='foot-full' --font="Iosevka Nerd Font:size=14" --override=pad=35x35 --config=$CONFIG
    elif [ "$1" == "-s" ]; then
      foot --app-id='foot-float' --config=$CONFIG \
        --window-size-pixels=$(slurp -b 1B1F28CC -c E06B74ff -s C778DD0D -w 2 -f "%wx%h")
    else
      foot --config="$CONFIG"
    fi
  '';

in {
  home.packages = with pkgs; [
    hyprlogout
    hyprmenu
    hyprterminal
  ];
}
