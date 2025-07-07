{ config, pkgs, ... }:

{
  # The home.packages option allows you to install Nix packages into your

  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    #ai
    uv

    neofetch
    git
    git-crypt
    gzip
    # neovim
    # gnupg
    nix-index
    nix-prefetch-git
    cachix
    direnv
    jq
    fd
    # ripgrep
    gh

    # Kubernetes
    kubectl
    kubernetes-helm
    k9s
    kubeswitch

    # Docker
    lazydocker

    # NATS
    natscli
    nats-top
    nkeys

    # Bun
    fnm
    pnpm
    yarn
    bun
    nodejs_24
    # flutter

    # Dev
    # supabase-cli too old

    # Shell
    # bash
    direnv
    btop
    zsh
    curl
    wget
    eza
    starship
    bat
    mdcat
    tree
    fzf
    zoxide
    tmux
    tmuxinator
    tmux-xpanes
    tmux-mem-cpu-load

    jetbrains-mono
    # (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.jetbrains-mono

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    ".ssh/config".source = ../ssh/config;
    ".config/starship.toml".source = ../zsh/starship.toml;
    ".config/wezterm/wezterm.lua".source = ../wezterm/wezterm.lua;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kronos/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nano";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash.enable = true;

  programs.git = {
    enable = true;
    userName = "Tarik TIRE";
    userEmail = "tarik@tire.fr";
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  programs.gh = {
    enable = true;
    settings = {
      aliases = {
        pr = "pr create";
        issue = "issue list";
        ci = "workflow list";
        co = "pr checkout";
        re = "pr ready";
        as = "auth status";
      };
      editor = "nano";
      git_protocol = "ssh";
    };
  };
}
