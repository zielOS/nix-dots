{ config, pkgs, ... }:

{
  users.users.root.initialPassword = "changeme";
  users.users.ahsan = {
    isNormalUser = true;
    description = "Ahsanur Rahman";
    extraGroups = [ 
      "networkmanager" 
      "wheel"
      "systemd-journal"
      "audio"
      "video"
      "input"
      "power"
      "nix"
    ];
    useDefaultShell = true;
    shell = pkgs.zsh;
    initialPassword = "changeme";    
    packages = with pkgs; [ ];
  };
}
