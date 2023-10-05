{ config, pkgs, lib, ... }:

{
  boot = {
    tmp.cleanOnBoot = true;
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    extraModulePackages = [ config.boot.kernelPackages.exfat-nofuse ];
    initrd.verbose = true;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/boot/efi";   
    };
    initrd.secrets = {
      "/crypto_keyfile.bin" = null;
    };
  };
}
