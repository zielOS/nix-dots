{ config, pkgs, lib, inputs, ... }:

{

  environment = {
  # set channels (backwards compatibility)
    etc = {
      "nix/flake-channels/nixpkgs".source = inputs.nixpkgs;
      "nix/flake-channels/home-manager".source = inputs.home-manager;
    };

    # we need git for flakes
    systemPackages = [pkgs.git];
    defaultPackages = [];
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      tarball-ttl = 0;
    };
    
    hostPlatform = {
      system = "x86_64-linux";
      config = "x86_64-unknown-linux-gnu";
    
    };

    overlays = with inputs; [
      rust-overlay.overlays.default
      nur.overlay
      emacs-overlay.overlay
    ];
  };

# faster rebuilding
  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 4d";
    };
    #package = pkgs.nixUnstable;
    package = pkgs.nixFlakes;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # set the path for channels compat
    nixPath = [
      "nixpkgs=/etc/nix/flake-channels/nixpkgs"
      "home-manager=/etc/nix/flake-channels/home-manager"
    ];

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      cores = 12
      auto-optimise-store = true;
      builders-use-substitutes = true;
      trusted-users = ["root" "@wheel"];
      max-jobs = "auto";
      system-features = [
      "nixos-test" 
      "benchmark" 
      "big-parallel" 
      "kvm" 
     ];

      # use binary cache, its not gentoo

    };
  };


# Autoupdate
  system.autoUpgrade = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Dont touch this

}
