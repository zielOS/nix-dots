{ pkgs, lib, config, ... }:

{
  home.file = {
    "local/bin/actions" = {
      executable = true;
      text = ''
        #> Syntax: bash
        # Ask for confirmation
        cdialog () {
          yad --title='Confirm?' --borders=10 --center --fixed --button=Yes:0 --button=No:1 --text="Are you sure?" --text-align=center
        }

        if [[ "$1" == '--shutdown' ]]; then
          cdialog
          if [[ "$?" == 0 ]]; then
            sudo systemctl poweroff
          else
            exit
          fi
        elif [[ "$1" == '--reboot' ]]; then
          cdialog
          if [[ "$?" == 0 ]]; then
            sudo systemctl reboot
          else
            exit
          fi
        elif [[ "$1" == '--hibernate' ]]; then
          cdialog
          if [[ "$?" == 0 ]]; then
            sudo systemctl hibernate
          else
            exit
          fi
        elif [[ "$1" == '--lock' ]]; then
          ~/.config/bin/lockscreen
        elif [[ "$1" == '--suspend' ]]; then
          cdialog
          if [[ "$?" == 0 ]]; then
            amixer set Master mute
            ~/.config/bin/lockscreen
            sudo systemctl suspend
          else
            exit
          fi
        elif [[ "$1" == '--logout' ]]; then
          cdialog
          if [[ "$?" == 0 ]]; then
            kill -9 -1
          else
            exit
          fi
        fi         
      '';
    };
  };  

}
