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
    package = pkgs.nixUnstable;
    #package = pkgs.nixFlakes;

    # Make builds run with low priority so my system stays responsive
    # daemonCPUSchedPolicy = "idle";
    # daemonIOSchedClass = "idle";

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Free up to 1GiB whenever there is less than 100MiB left.
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = false
      warn-dirty = true
      keep-derivations = false
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
      max-jobs = 2;
      cores = 12;
      keep-going = true;
      log-lines = 50;
      system-features = [
        "big-parallel" 
        "gccarch-alderlake"
      ];
      extra-experimental-features = ["flakes" "nix-command" "ca-derivations"];
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      permittedInsecurePackages = [
        "openssl-1.1.1u"
        "electron-25.9.0"
      ];
    };

    overlays = with inputs; [
      rust-overlay.overlays.default
      nur.overlay
      emacs-overlay.overlay
      #inputs.nix-doom-emacs.overlay
    ];

    localSystem = { 
      system = "x86_64-linux";
      #gcc.arch = "alderlake";
    };

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
