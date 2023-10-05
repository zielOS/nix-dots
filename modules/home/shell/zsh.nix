{ config, lib, pkgs, ...}:
{
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    history = {
      save = 10000;
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
      zstyle ':completion:*' completer _complete _match _approximate
      zstyle ':completion:*:match:*' original only
      zstyle ':completion:*:approximate:*' max-errors 1 numeric
      zstyle ':completion:*' sort false
      zstyle ':completion:complete:*:options' sort false
      zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
      zstyle ':completion:*' special-dirs true
      zstyle ':completion:*' rehash true
      zstyle ':completion:*' menu yes select # search
      zstyle ':completion:*' list-grouped false
      zstyle ':completion:*' list-separator '''
      zstyle ':completion:*' group-name '''
      zstyle ':completion:*' verbose yes
      zstyle ':completion:*:matches' group 'yes'
      zstyle ':completion:*:warnings' format '%F{red}%B-- No match for: %d --%b%f'
      zstyle ':completion:*:messages' format '%d'
      zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':fzf-tab:*' command $FZF_TAB_COMMAND
      zstyle ':fzf-tab:*' switch-group ',' '.'
      zstyle ':fzf-tab:complete:_zlua:*' query-string input
      zstyle ':fzf-tab:complete:*:*' fzf-preview 'preview.sh $realpath'
      zstyle ":completion:*:git-checkout:*" sort false
      zstyle ':completion:*' file-sort modification
      zstyle ':completion:*:exa' sort false
      zstyle ':completion:files' sort false
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -v '^?' backward-delete-char
    '';

    shellAliases = with pkgs; {
      cleanup = "sudo nix-collect-garbage && sudo nix-collect-garbage -d";
      nixup = "cd ~/nixos-dotfiles && sudo nixos-rebuild switch --flake '.#workstation' --upgrade"; 
      nixin = "cd ~/nixos-dotfiles && sudo nixos-rebuild switch --flake '.#workstation'"; 
      
      bloat = "nix path-info -Sh /run/current-system";
      fcd = "cd $(find -type d | fzf)";
      g = "lazygit";
      grep = lib.getExe ripgrep;
      du = lib.getExe du-dust;
      ps = lib.getExe procs;
      rm = lib.getExe trash-cli;
      cat = "${lib.getExe bat} --style=plain";
      l = "${lib.getExe exa} -lF --time-style=long-iso --icons";
      la = "${lib.getExe exa} -lah --tree";
      ls = "${lib.getExe exa} -h --git --icons --color=auto --group-directories-first -s extension";
      tree = "${lib.getExe exa} --tree --icons --tree";
    };

    zplug = {
      enable = true;
      zplugHome = "${config.xdg.configHome}/zsh/zplug";
      plugins = [
        {name = "zsh-users/zsh-syntax-highlighting";}
        {name = "zsh-users/zsh-history-substring-search";}
        {name = "zsh-users/zsh-completions";}
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "hlissner/zsh-autopair";}
        {name = "chisui/zsh-nix-shell";}
        {name = "Aloxaf/fzf-tab";}
      ];
    };
  };
}
