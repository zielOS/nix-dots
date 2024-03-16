{ config, pkgs,  ... }:

let
  gcc13optimized = pkgs.gcc.override {
    self = gcc13optimized;
    langJit = true;
    enableLTO = true;
    profiledCompiler = true;
    reproducibleBuild = false;
  };

in {
  environment.systemPackages = with pkgs; [
    gcc13optimized
    libgcc
    libgccjit
  ];

}
