# Shell configuration for zsh (frequently used) and fish (used just for fun)

{ config, lib, pkgs, ... }:

let
  # Set all shell aliases programatically
  shellAliases = {
    # Aliases for commonly used tools
    grep = "grep --color=auto";
    circleci = "circleci-cli";
    just = "just --no-dotenv";
    diff = "diff --color=auto";
    cat = "bat";
    we = "watchexec";
    ll = "ls -lh";
    ls = "eza --icons=always";
    dk = "docker";
    k = "kubectl";
    bb = "broot";
    dc = "docker-compose";
    md = "mdcat";
    hms = "nix run home-manager -- switch --flake ~/dotfiles/home#krs";
    top = "btop --update 33";

    # Reload zsh
    szsh = "source ~/.zshrc";

    # Reload home manager and zsh
    reload = "nix run home-manager -- switch --flake ~/dotfiles/home && source ~/.zshrc";

    # Nix garbage collection
    garbage = "nix-collect-garbage -d";

    # See which Nix packages are installed
    installed = "nix-env --query --installed";

    ks = "switch";
  };
in {

  # Fancy filesystem navigator
  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    #    defaultCommand = "${pkgs.ripgrep}/bin/rg --files";
  };

  # Set zsh as the default shell if the terminal is xterm, xterm-256color, or screen
  programs.bash = {
    initExtra = ''
        if [ $TERM = "xterm" -o $TERM = "xterm-256color" -o $TERM = "screen" ] && type zsh &> /dev/null
        then
            export SHELL=$(which zsh)
            if [[ -o login ]]
            then
                exec zsh -l
            else
                exec zsh
            fi
        fi
    '';
  };

  # zsh settings
  programs.zsh = {
    inherit shellAliases;
    enable = true;
    autosuggestion = {
      enable = true;
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    history.extended = true;

    # Called whenever zsh is initialized
    initContent = ''
      export TERM="xterm-256color"
      # bindkey -e

      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char

      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word

      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

    #   # Nix setup (environment variables, etc.)
    #   if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
    #     . ~/.nix-profile/etc/profile.d/nix.sh
    #   fi

      # Load environment variables from a file; this approach allows me to not
      # commit secrets like API keys to Git
      if [ -e ~/.env ]; then
        . ~/.env
      fi

      # Start up Starship shell
      eval "$(starship init zsh)"

      eval "$(zoxide init zsh)"

      # fnm setup (environment variables, etc.)
      fnm default 24
      eval "$(fnm env --use-on-cd --shell zsh)"

      # Autocomplete for various utilities
      source <(helm completion zsh)
      source <(kubectl completion zsh)
      source <(gh completion --shell zsh)
      source <(npm completion zsh)

      # direnv hook
      eval "$(direnv hook zsh)"

      # kubeswitch
      source <(switcher init zsh)
      source <(switch completion zsh)
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
