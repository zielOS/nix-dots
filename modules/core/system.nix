{ config, pkgs, ... }:

{
  services = {
    dbus = {
      packages = with pkgs; [dconf gcr udisks2];
      enable = true;
    };
    udev.packages = with pkgs; [gnome.gnome-settings-daemon];
    journald.extraConfig = ''
      SystemMaxUse=50M
      RuntimeMaxUse=10M
    '';
    udisks2.enable = true;
    gvfs.enable = true;
    # profile-sync-daemon
    psd = {
      enable = true;
      resyncTimer = "10m";
    };

  };
  programs = {
    dconf.enable = true;
    zsh.promptInit = ''eval "$(${pkgs.starship}/bin/starship init zsh)"'';
  };

  # compress half of the ram to use as swap
  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "brave";
    TERMINAL = "alacritty";
  };
  
  environment.sessionVariables = {
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME    = "\${HOME}/.local/bin";
    NPM_HOME = "\${HOME}/.npm-global/bin";
    HYPRSHOT_DIR =  "\${HOME}/Pictures";
    
    #NIX_PATH = "\${HOME}/nixpkgs/lib/systems/architectures.nix ";

    PATH = [
      "\${XDG_BIN_HOME}"
      "\${NPM_HOME}"
    ];	

  };
  environment.systemPackages = with pkgs; [
    git
    xfce.thunar
    wget
    emacs29-pgtk
    lazygit
    linux-firmware
    nodejs
    gh
    linuxHeaders
    bleachbit
    xfce.xfconf
    gparted
    python3
    gcc13
    perl
    gnumake
    rustup
    cmake
    aide
    fd
    neovim
    starship
    s-tui
    chkrootkit
    killall
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    nvidia-vaapi-driver
  ];

  environment.etc = {
    issue = {
      text = ''
 -- WARNING -- This system is for the use of authorized users only. Individuals 
 using this computer system without authority or in excess of their authority 
 are subject to having all their activities on this system monitored and 
 recorded by system personnel. Anyone using this system expressly consents to 
 such monitoring and is advised that if such monitoring reveals possible 
 evidence of criminal activity system personal may provide the evidence of such 
 monitoring to law enforcement officials.
 '';
      mode = "0440";
    };  
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
    thunar-media-tags-plugin
  ];

  time = {
    timeZone = "America/Edmonton";
    hardwareClockInLocalTime = true;
  };
  
  i18n.defaultLocale = "en_CA.UTF-8";
  console.keyMap = "us";
}
