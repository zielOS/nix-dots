{ config, pkgs, nixpkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fastStdenv
    with cudaPackages; [
      cudatoolkit
      cudnn
    ];
  ];
}
