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
    nodejs

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
    "$HOME/.dotnet/tools"
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
    mouse = true;
    escapeTime = 0;
    historyLimit = 50000;
    baseIndex = 1;
    prefix = "C-a";
    terminal = "screen-256color";

    extraConfig = ''
      # True color support
      set -ga terminal-overrides ",xterm-256color:Tc"

      # Panes start at 1, auto-renumber
      setw -g pane-base-index 1
      set -g renumber-windows on

      # Status bar — top
      set -g status-position top
      set -g status-interval 5
      set -g status-left-length 30
      set -g status-right-length 50

      # Tokyo Night theme
      set -g status-style "bg=#1a1b26,fg=#a9b1d6"
      set -g status-left "#[fg=#7aa2f7,bold] #S #[default]│"
      set -g status-right "#[fg=#565f89]%H:%M #[fg=#7aa2f7]%d/%m"
      setw -g window-status-format "#[fg=#565f89] #I:#W "
      setw -g window-status-current-format "#[fg=#1a1b26,bg=#7aa2f7] #I:#W "
      set -g pane-border-style "fg=#3b4261"
      set -g pane-active-border-style "fg=#7aa2f7"
      set -g message-style "bg=#1a1b26,fg=#7aa2f7"

      # Vi copy mode
      setw -g mode-keys vi
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard 2>/dev/null || pbcopy 2>/dev/null"

      # Prefix passthrough
      bind C-a send-prefix

      # Reload
      bind r source-file ~/.config/tmux/tmux.conf \; display 'Config reloaded ✓'

      # Splits: | = vertical, - = horizontal (preserve cwd)
      bind | split-window -h -c '#{pane_current_path}'
      bind - split-window -v -c '#{pane_current_path}'

      # Vim-style pane movement
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Alt+arrows — switch panes (NO prefix)
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D

      # Alt+1-9 — switch panes (NO prefix)
      bind -n M-1 select-pane -t 1 2>/dev/null || true
      bind -n M-2 select-pane -t 2 2>/dev/null || true
      bind -n M-3 select-pane -t 3 2>/dev/null || true
      bind -n M-4 select-pane -t 4 2>/dev/null || true
      bind -n M-5 select-pane -t 5 2>/dev/null || true
      bind -n M-6 select-pane -t 6 2>/dev/null || true
      bind -n M-7 select-pane -t 7 2>/dev/null || true
      bind -n M-8 select-pane -t 8 2>/dev/null || true
      bind -n M-9 select-pane -t 9 2>/dev/null || true

      # Ctrl+Alt+1-9 — switch windows (NO prefix) (more reliable on some terminals)
      bind -n C-M-1 select-window -t 1
      bind -n C-M-2 select-window -t 2
      bind -n C-M-3 select-window -t 3
      bind -n C-M-4 select-window -t 4
      bind -n C-M-5 select-window -t 5
      bind -n C-M-6 select-window -t 6
      bind -n C-M-7 select-window -t 7
      bind -n C-M-8 select-window -t 8
      bind -n C-M-9 select-window -t 9

      # Synchronize panes toggle
      bind s setw synchronize-panes \; display "Sync panes #{?synchronize-panes,ON,OFF}"

      # Window navigation (with prefix)
      bind n next-window
      bind p previous-window
    '';
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
