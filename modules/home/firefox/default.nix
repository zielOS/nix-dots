{ config, pkgs, ... }: 

{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    profiles = {
      ahsan = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          adnauseam
          canvasblocker
          enhanced-github
          octotree
          tree-style-tab
          refined-github 
          ublock-origin 
        ];

        id = 0;
        settings = {
          "general.smoothScroll" = true;
        };

        userChrome = import ./userChrome-css.nix;

        extraConfig = ''
          user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
          user_pref("full-screen-api.ignore-widgets", true);
          user_pref("media.ffmpeg.vaapi.enabled", true);
          user_pref("media.rdd-vpx.enabled", true);
          user_pref("svg.context-properties.content.enabled", true);
          user_pref("layout.css.color-mix.enabled", true);
        '';
      };
    };
  };
}
