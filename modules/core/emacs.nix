{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs29-pgtk;  # replace with pkgs.emacsPgtk, or another version if desired.
      config = ../home/emacs/init.el;
      alwaysTangle = true;
      # config = path/to/your/config.org; # Org-Babel configs also supported

      # Optionally provide extra packages not in the configuration file.
      extraEmacsPackages = epkgs: [
        # epkgs.use-package
        # epkgs.no-littering
        # epkgs.all-the-icons
        # epkgs.all-the-icons-dired
      ];

      # Optionally override derivations.
      override = epkgs: epkgs // {
        somePackage = epkgs.melpaPackages.somePackage.overrideAttrs(old: {
           # Apply fixes here
        });
      };
    })
  ];
}
