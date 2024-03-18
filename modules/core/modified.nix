{config, pkgs, ... }:

let

  elfutils = pkgs.elfutils.overrideAttrs (oldAttrs: rec {
     doCheck = false;
    doInstallCheck = false;
  });


in {
  environment.systemPackages = with pkgs; [
    elfutils
  ];


}
