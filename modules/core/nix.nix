{ config, pkgs, lib, inputs, ... }:

{
  environment = {
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
      builders-use-substitutes = false;
      allowed-users = ["@wheel"];
      trusted-users = ["@wheel"];
      sandbox = true;
      max-jobs = "auto";
      keep-going = true;
      log-lines = 50;
      system-features = [
        "big-parallel" 
        "gccarch-alderlake"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://nixpkgs-unfree.cachix.org"
        "https://hyprland.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nixpkgs-unfree.cachix.org-1:hqvoInulhbV4nJ9yJOEr+4wxhDV4xq2d1DK7S6Nj6rs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
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
/*       emacs-overlay.overlay */
      #inputs.nix-doom-emacs.overlay
    ];

    # localSystem = { 
    #   system = "x86_64-linux";
    #   gcc.arch = "alderlake"; 
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
