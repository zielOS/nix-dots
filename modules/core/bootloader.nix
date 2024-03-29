{ config, pkgs, lib, ... }:

{
  boot = {
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelParams = [
      "audit=1"
      "apparmor=1" 
      "security=apparmor"
    ];
    initrd.verbose = true;
    loader = {
      systemd-boot.enable = true;
      timeout = 5;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";   
    };
  };
}
