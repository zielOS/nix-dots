let
  pkgs = import <nixpkgs> {
    overlays = [
      (self: super: {
        stdenv = super.impureUseNativeOptimizations super.stdenv;
      })
    ];
  };
in
  pkgs.openssl
