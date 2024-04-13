{ config, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nvim-autopairs
      nvim-ts-context-commentstring
      nvim-web-devicons
      nvim-tree-lua
      bufferline-nvim
      vim-bbye
      lualine-nvim
      toggleterm-nvim
      project-nvim
      impatient-nvim
      indent-blankline-nvim
      alpha-nvim
      nvchad
    ];

  };
}
