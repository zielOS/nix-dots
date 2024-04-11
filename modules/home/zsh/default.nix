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
        la = "lsd -a";
        update = "sudo nixos-rebuild switch --flake .#workstation -I ~/nix-dots/";
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
