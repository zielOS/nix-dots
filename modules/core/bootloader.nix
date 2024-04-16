{ config, pkgs, lib, ... }:

{
  boot = {
    tmp = {
      cleanOnBoot = true;
      useTmpfs = false;
    };
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "audit=1"
      "security=selinux"
    ];
    initrd.verbose = false;
    bootspec.enable = true;
    loader = {
      systemd-boot.enable = true;
      timeout = 5;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot";   
    };
  };
}
