{ config, pkgs, fastStdenv, ... }:

let
  pkgs = import <nixpkgs> {
    overlays = [
      (self: super: {
        stdenv = super.impureUseNativeOptimizations super.stdenv;
      })
    ];
  };
in {
  environment.systemPackages = with pkgs; [
    gcc
    python3
    clang
    llvm
    perl
  ];

}
