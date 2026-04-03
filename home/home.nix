{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [

    # AI
    uv

    # Core
    fastfetch
    git-crypt
    gzip
    nix-index
    nix-prefetch-git
    cachix
    jq
    yq
    fd
    ripgrep

    # Kubernetes
    kubectl
    kubernetes-helm
    kubeswitch

    # Docker
    lazydocker

    # NATS
    natscli
    nats-top
    nkeys

    # JS/TS
    fnm
    pnpm
    yarn
    bun
    nodePackages_latest.nodejs

    # Shell
    zsh
    curl
    wget
    mdcat
    tree
    tmuxinator
    tmux-xpanes
    tmux-mem-cpu-load
    go-task
    lazygit

    # Fonts
    jetbrains-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    ".config/starship.toml".source = ../zsh/starship.toml;
    ".config/wezterm/wezterm.lua".source = ../wezterm/wezterm.lua;
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.sessionVariables = {
    EDITOR = "nano";
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.bash.enable = true;

  # --- Managed programs (HM modules) ---

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Tarik TIRE";
        email = "tarik@tire.fr";
      };
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere.enable = true;
    };
  };

  programs.delta.enable = true;

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.bat.enable = true;

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    icons = "auto";
  };

  programs.btop.enable = true;

  programs.k9s.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;
    mouse = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [ "--height 40%" "--layout=reverse" "--border" ];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidgetOptions = [ "--preview 'bat --style=numbers --color=always --line-range :500 {}'" ];
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
  };
}
