{ config, pkgs,  ... }:

let
  python3optimized = pkgs.python3.override {
    self = python3optimized;
    enableOptimizations = true;
    reproducibleBuild = false;
    packageOverrides = python-self: python-super: {
      curio = python-super.curio.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });
      cffi = python-super.cffi.overridePythonAttrs (oldAttrs: {
        doCheck = false;
      });
    };
  };
  pyPkgs = python3optimized.pkgs;

in {
  environment.systemPackages = with pyPkgs; [
    cython_3
    numpy
    pandas 
    matplotlib
    jupyter
    scipy
  ];

}
