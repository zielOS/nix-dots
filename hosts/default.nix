{ nixpkgs, self, chaotic, nixos-hardware, ... }:

let
  inputs = self.inputs;
  bootloader = ../modules/core/bootloader.nix;
  core = ../modules/core;
  emacs = ../modules/emacs;
  nvidia = ../modules/nvidia;
  wayland = ../modules/wayland;
  laptop = nixos-hardware.nixosModules.asus-zephyrus-ga401;
  chaotic_nix = chaotic.homeManagerModules.default;
  pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
/*   asztal = pkgs.callPackage ../modules/ags { inherit inputs; }; */
  hmModule = inputs.home-manager.nixosModules.home-manager;
  /* doom_emacs = nix-doom-emacs.hmModule; */

  shared = [core];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
/*       inherit asztal; */
      inherit chaotic_nix;
    };
    users.ahsan = {
      imports = [ 
        (import ../modules/home) 
      ];
      _module.args.theme = import ../theme;
    }; 
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
        #emacs
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
        #laptop
        
        {inherit home-manager;}
      ]
      ++shared;
    specialArgs = {inherit inputs;};
  };
}
