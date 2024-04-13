{
  config,
  lib,
  pkgs,
  ...
}: {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cl = "git clone";
        g = "lazygit";
        l = "lsd";
        Rm = "sudo rm -rf";
        la = "lsd -a";
        fetch = "fastfetch";
        v = "nvim";
        nix-cl = "sudo nix-collect-garbage -d";
        audit = "sudo lynis audit system";
        nix-up = "sudo nixos-rebuild switch --flake .#workstation --upgrade";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
