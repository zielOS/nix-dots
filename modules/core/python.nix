{ config, pkgs,  ... }:

let
  python311optimized = pkgs.python311.override {
    self = python311optimized;
    enableOptimizations = true;
    reproducibleBuild = false;
    packageOverrides = python-self: python-super: {
      curio = python-super.curio.overridePythonAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
      });
      cffi = python-super.cffi.overridePythonAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
      });
      websockets = python-super.websockets.overridePythonAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
      });
      SQLAlchemy = python-super.SQLAlchemy.overridePythonAttrs (oldAttrs: {
        doCheck = false;
        doInstallCheck = false;
      });
      
    };
  };

in {
  environment.systemPackages = with pkgs; [
    (python311optimized.withPackages (p: with p; [
      pandas
      numpy
      scipy
      keras
      scikit-learn
      cython_3
      jupyter
      pyarrow
      pip
      setuptools
      tensorflowWithCuda
    ]))
  ];

}
