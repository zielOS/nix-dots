{ config, pkgs, nixpkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fastStdenv 
      cudaPackages.cudatoolkit
      cudaPackages.cudnn
  ];
}
