{ config, pkgs, fastStdenv, ... }:

fastStdenv.mkDerivation {
   name = "env";
}

# let
#   gcc13optimized = pkgs.libgcc.override {
#     self = gcc13optimized;
#     langJit = true;
#     enableLTO = true;
#     profiledCompiler = true;
#     reproducibleBuild = false;
#   };

{
  environment.systemPackages = with pkgs; [
    env.gcc
  ];

}
