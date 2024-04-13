{ config, pkgs, ...}: {
  home.packages = with pkgs; [zsh-forgit gitflow];
  programs.git = {
    enable = true;
    userName = "zielOS";
    userEmail = "ahsanur041@gmail.com";
    lfs.enable = true;
    delta.enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = "ahsanur041@gmail.com";
      push.autoSetupRemote = true;
    };

  };
}


