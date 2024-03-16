{ config, pkgs,  ... }:

let
  python311optimized = pkgs.python311.override {
    self = python311optimized;
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
# let
#   python311optimized = pkgs.python311.override {
#     self = python311optimized;
#     enableOptimizations = true;
#     reproducibleBuild = false;
#   };

in {
  environment.systemPackages = with pkgs; [
    (python311optimized.withPackages (p: with p; [
      pandas
      numpy
      scipy
      #scikit-learn
      cython_3
      jupyter
      pyarrow
    ]))
  ];

}
