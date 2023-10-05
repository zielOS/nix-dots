''
* {
  font-family: "JetBrainsMono Nerd Font";
  font-size: 14px;
  font-weight: bold;
}

window {
  background-color: #1E1E2E;
}

button {
  background-color: #242434;
  color: #FFFFFF;
  border: 2px solid #282838;
  border-radius: 20px;
  background-repeat: no-repeat;
  background-position: center;
  background-size: 35%;
}

button:focus, button:active, button:hover {
  background-color: #89B4FA;
  outline-style: none;
}

#lock {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/lock.png"), url("/usr/share/wlogout/icons/lock.png"));
}

#logout {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/layout.png"), url("/usr/share/wlogout/icons/layout.png"));
}

#suspend {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/suspend.png"), url("/usr/share/wlogout/icons/suspend.png"));
}

#hibernate {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/hibernate.png"), url("/usr/share/wlogout/icons/hibernate.png"));
}

#shutdown {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/shutdown.png"), url("/usr/share/wlogout/icons/shutdown.png"));
}

#reboot {
  background-image: image(url("~/nixos-dotfiles/modules/home/wlogout/icons/reboot.png"), url("/usr/share/wlogout/icons/reboot.png"));
}
''
