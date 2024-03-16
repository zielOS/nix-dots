{ config, pkgs,  ... }:

let
  python311optimized = pkgs.python311.override {
    self = python311optimized;
    enableOptimizations = true;
    reproducibleBuild = false;
  };

in {
  environment.systemPackages = with pkgs; [
    (python311optimized.withPackages (p: with p; [
      pandas
      numpy
      scipy
      scikit-learn
      cython_3
      jupyter
    ]))
  ];

}
