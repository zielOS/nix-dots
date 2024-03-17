{config, pkgs, ... }:

let
  python_mod = (pkgs.python3.override {
    doCheck = false;
    doInstallCheck = false;
  });
  clang_mod = (pkgs.clang.override {
    doCheck = false;
    doInstallCheck = false;
  });
  llvm_mod = (pkgs.llvm.override {
    doCheck = false;
    doInstallCheck = false;
  });



in {
  environment.systemPackages = with pkgs; [
  elfutils = (pkgs.elfutils.override {
    doCheck = false;
    doInstallCheck = false;
  });
  ];


}
