{ config, pkgs, fastStdenv, ... }:

let
  pkgs = import <nixpkgs> {
    localSystem = {
      system = "x86_64-linux";
    };
  };
in
  pkgs.elfutils

