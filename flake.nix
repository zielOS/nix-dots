{
  description = "My NixOS configuration";

  inputs = {
    ags.url = "github:Aylur/ags";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal.url = "github:Aylur/astal";
    matugen.url = "github:InioX/matugen";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    hyprland.url = "github:hyprwm/Hyprland/";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    Hyprspace = {
      url = github:KZDKM/Hyprspace;
      inputs.hyprland.follows = "hyprland";
    };

    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    nur.url = "github:nix-community/NUR";
    devshell.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
    xdg-portal-hyprland.url = "github:hyprwm/xdg-desktop-portal-hyprland";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprlang = {
      url = "github:hyprwm/hyprlang";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming.url = "github:fufexan/nix-gaming";
    stm.url = "github:Aylur/stm";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	  
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    
    emacs = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.emacs.follows = "emacs";
    };
  };
  outputs = { 
    self, 
    nixpkgs, 
    chaotic, 
    home-manager, 
    anyrun, 
    emacs, 
    nix-doom-emacs, 
    ...

    } @ inputs: let
    system = "x86_64-linux";
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    asztal = pkgs.callPackage ./modules/ags { inherit inputs; };
  in {
    nixosConfigurations = import ./hosts inputs;

    packages.${system} = {
      default = asztal;
      #catppuccin-folders = pkgs.callPackage ./pkgs/catppuccin-folders.nix {};
      #catppuccin-gtk = pkgs.callPackage ./pkgs/catppuccin-gtk.nix {};
      #catppuccin-cursors = pkgs.callPackage ./pkgs/catppuccin-cursors.nix {};
      # onlyoffice-deb = pkgs.callPackage ./pkgs/onlyoffice-bin.nix {};
      # insync-deb = pkgs.callPackage ./pkgs/insync-deb.nix {};
    };
  };
}
