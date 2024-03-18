{ config, pkgs, fastStdenv, ... }:

let
  pkgs = import <nixpkgs> {
    overlays = [
      (self: super: {
        stdenv = super.impureUseNativeOptimizations super.stdenv;
      })
    ];
  };

  gccoptimized = pkgs.gcc-unwrapped.override {
    langJit = true;
    profiledCompiler = true;
    enableLTO = true;
    reproducibleBuild = false;
  };
  
in {
  environment.systemPackages = with pkgs; [
    gccoptimized
    clang
    llvm
    perl
    # sage
    # openssl
    # cmake
    # gnumake
    # nix
    # nodejs
  ];

}
