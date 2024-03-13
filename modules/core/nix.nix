{ config, pkgs, lib, inputs, ... }:

{

  environment = {
  # set channels (backwards compatibility)
    # we need git for flakes
    systemPackages = [pkgs.git];
    defaultPackages = [];
  };

  nix = {
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 3d";
    };
    # package = pkgs.nixUnstable;
    package = pkgs.nixFlakes;

   

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes recursive-nix
      keep-outputs = true
      warn-dirty = false
      keep-derivations = true
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
    settings = {
      flake-registry = "/etc/nix/registry.json";
      auto-optimise-store = true;
      # remove for building packages
      builders-use-substitutes = true;
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      sandbox = true;
      max-jobs = "auto";
      keep-going = true;
      log-lines = 20;
      system-features = [
        "benchmark" 
        "big-parallel" 
        "kvm" 
        "nixos-test"
        "recursive-nix"
        "gccarch-alderlake"
      ];
      /* extra-experimental-features = ["nix-command" "ca-derivations"]; */
    };
  };


  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
    };

    overlays = [
      inputs.rust-overlay.overlays.default
      inputs.nur.overlay
      #inputs.emacs-overlay.overlay
      #inputs.nix-doom-emacs.overlay
    ];

    
    # hostPlatform = {
    #   gcc.arch = "alderlake";
    #   gcc.tune = "x";
    #   system = "x86_64-linux";
    # };
  };

# faster rebuilding
  documentation = {
    enable = true;
    doc.enable = true;
    man.enable = true;
    dev.enable = false;
  };




# Autoupdate
  system.autoUpgrade = {
    enable = true;
  };

  system.stateVersion = "24.05"; # Dont touch this

}
