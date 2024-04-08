{ config, pkgs, fastStdenv, ... }:

let
  # pkgs = import <nixpkgs> {
  #   overlays = [
  #     (self: super: {
  #       stdenv = super.impureUseNativeOptimizations super.stdenv;
  #     })
  #   ];
  # };

  # gccoptimized = pkgs.gcc-unwrapped.override {
  #   langJit = true;
  #   profiledCompiler = true;
  #   enableLTO = true;
  #   reproducibleBuild = false;
  # };

  # python311optimized = pkgs.python311.override {
  #   self = python311optimized;
  #   enableOptimizations = true;
  #   reproducibleBuild = false;
  #   packageOverrides = python-self: python-super: {
  #     curio = python-super.curio.overridePythonAttrs (oldAttrs: {
  #       doCheck = false; doInstallCheck = false;
  #     });
  #     cffi = python-super.cffi.overridePythonAttrs (oldAttrs: {
  #       doCheck = false; doInstallCheck = false;
  #     });
  #     websockets = python-super.websockets.overridePythonAttrs (oldAttrs: {
  #       doCheck = false; doInstallCheck = false;
  #     });
  #     SQLAlchemy = python-super.SQLAlchemy.overridePythonAttrs (oldAttrs: {
  #       doCheck = false; doInstallCheck = false;
  #     });
  #     
  #   };
  # };

  # elfutils = pkgs.elfutils.override {
  #   doCheck = false;
  #   doInstallCheck = false;
  #   enableParallelBuilding = false;
  #   enableDebuginfod = false;
  # };

in {
  environment.systemPackages = with pkgs; [
    # (python311optimized.withPackages (p: with p; [
    #   pandas
    #   numpy
    #   scipy
    #   keras
    #   scikit-learn
    #   cython_3
    #   jupyter
    #   pyarrow
    #   pip
    #   setuptools
    #   #tensorflowWithCuda
    # ]))
    xfce.thunar
    xfce.exo
    xfce.xfconf
    xfce.tumbler
    xfce.catfish
    xfce.thunar-volman
    xfce.thunar-media-tags-plugin
    xfce.thunar-archive-plugin
    #gccoptimized
    cachix
    wget
    lazygit
    linux-firmware
    btop
    bleachbit
    fd
    gnumake
    chkrootkit
    killall
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
    nvidia-vaapi-driver
    tealdeer
    tree
    #sage
    #cudaPackagesGoogle.cudatoolkit
    # clang
    # llvm
    # perl
    # sage
    openssl
    cmake
    gnumake
    element-desktop
    alacritty
    insync
    kitty
    lutris
    brave
    fastfetch
    lsd
    git
    cached-nix-shell 
    typescript
    fzf
    nodejs
    cargo
    lynis
    unzip
    ripgrep
    ffmpeg
    pymol
    xournalpp
    imagemagick
    deluge
    fd
    jq 
    lm_sensors
    catppuccin-gtk
    nodejs
  ];

}
