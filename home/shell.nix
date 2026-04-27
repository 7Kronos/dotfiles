# Shell configuration for zsh

{ config, lib, pkgs, ... }:

let
  shellAliases = {
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
    lg = "lazygit";
    top = "btop --update 33";
    hms = "home-manager switch --flake ~/dotfiles/home";
    hmc = "nix flake check --no-build ~/dotfiles/home";
    hmu = "nix flake update --flake ~/dotfiles/home && home-manager switch --flake ~/dotfiles/home && source ~/.zshrc";
    szsh = "source ~/.zshrc";
    reload = "home-manager switch --flake ~/dotfiles/home && source ~/.zshrc";
    garbage = "nix-collect-garbage -d";
    installed = "nix-env --query --installed";
    ks = "switch";
    tcode = "tmux new-session -A -s code";
    tinfra = "tmux new-session -A -s infra";
  };
in {

  programs.broot = {
    enable = true;
    enableZshIntegration = true;
  };

  # Set zsh as the default shell from bash
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

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };
    history = {
      size = 50000;
      save = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      export TERM="xterm-256color"

      bindkey  "^[[H"   beginning-of-line
      bindkey  "^[[F"   end-of-line
      bindkey  "^[[3~"  delete-char
      bindkey '^[[1;5D' backward-word
      bindkey '^[[1;5C' forward-word
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward

      # Load environment variables from a file (secrets, API keys)
      if [ -e ~/.env ]; then
        . ~/.env
      fi

      # fnm setup
      fnm default 24
      eval "$(fnm env --use-on-cd --shell zsh)"

      # Autocomplete for tools without HM integration
      source <(helm completion zsh)
      source <(kubectl completion zsh)
      source <(npm completion zsh)

      # kubeswitch
      source <(switcher init zsh)
      source <(switch completion zsh)

      export SSL_CERT_DIR="$HOME/.aspnet/dev-certs/trust"
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
