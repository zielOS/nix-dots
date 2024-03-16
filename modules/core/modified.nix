{config, pkgs, ... }:

let
  modified = pkgs.override {
    self = modified;
    packageOverrides = pkgs: rec {
      elfutils = pkgs.elfutils.override { doCheck = false; doInstallCheck = false; };
    };
  };
  modifiednixpkgs = modified.pkgs;
  
in {
  environment.systemPackages = with modifiednixpkgs; [
    elfutils
   
  ];


};
