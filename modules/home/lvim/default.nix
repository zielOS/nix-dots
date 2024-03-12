{ config, pkgs, ... }:

{ 
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      clangd_extensions-nvim
      dressing-nvim
      nvim-dap
      nvim-dap-python
      neotest
      neotest-python
      vimtex
      cmp-latex-symbols
      ultisnips
      tex-conceal-vim
      catppuccin-nvim
    ]
  };
  home = { 
    packages = with pkgs; [ lunarvim ];
    file.".config/lvim/config.lua".source  = ./config.lua;
  };
}

