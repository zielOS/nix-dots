{ nixpkgs, self, ... }:

let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  asztal = pkgs.callPackage ../modules/ags { inherit inputs; };
  hmModule = inputs.home-manager.nixosModules.home-manager;

  shared = [core];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit asztal;
    };
    users.ahsan = import ../modules/home;
  };

in {
  # workstation
  workstation = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "workstation";}
        ./workstation/hardware-configuration.nix
        bootloader 
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
        ++shared;
    specialArgs = {inherit inputs;};
  };

  #zephyrus
  zephyrus = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "zephyrus";}
        ./zephyrus/hardware-configuration.nix
        bootloader
        nvidia
        wayland
        hmModule
        {inherit home-manager;}
      ]
      ++shared;
    specialArgs = {inherit inputs;};
  };
}
