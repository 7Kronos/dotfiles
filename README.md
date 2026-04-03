# Tarik's Dotfiles

Home Manager configuration managed with Nix flakes. Deploys on multiple machines with per-host targets.

## Machines

| Target | User | Host |
|--------|------|------|
| `krs@BATTLESTAR` | krs | BATTLESTAR (desktop) |
| `kronos@KRS` | kronos | KRS (office) |
| `kronos@KRSBOOK` | kronos | KRSBOOK (laptop) |
| `admin@klaw` | admin | klaw (server) |

## Quick start

```sh
# Install Nix
sh <(curl -L https://nixos.org/nix/install) --daemon

# Enable flakes
echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
sudo systemctl restart nix-daemon.service

# Clone and apply
nix run nixpkgs#gh -- auth login
nix run nixpkgs#gh -- repo clone 7kronos/dotfiles ~/dotfiles
nix run home-manager -- switch --flake ~/dotfiles/home
```

Home Manager auto-detects `$USER@$HOSTNAME` to pick the right target.

## Usage

```sh
# Apply config (or use the 'hms' alias)
home-manager switch --flake ~/dotfiles/home

# Update flake inputs (nixpkgs + home-manager)
cd ~/dotfiles/home && nix flake update

# Garbage collect old generations
nix-collect-garbage -d
```

## What's included

**Shell**: zsh, starship prompt, fzf (with fd/bat preview), zoxide, broot, direnv + nix-direnv

**Dev tools**: git (with delta diff), gh, ripgrep, fd, jq, yq, bat, eza, lazygit, lazydocker, go-task

**JS/TS**: fnm, bun, pnpm, yarn, nodejs

**Kubernetes**: kubectl, helm, k9s, kubeswitch

**NATS**: natscli, nats-top, nkeys

## Structure

```
home/
  flake.nix       # Flake definition with all machine targets
  home.nix        # Shared packages and program configs
  shell.nix       # Zsh config, aliases, shell integrations
  targets/        # Per-machine username/homeDirectory
ssh/config        # SSH config (symlinked)
wezterm/          # Wezterm terminal config (symlinked)
zsh/starship.toml # Starship prompt theme (symlinked)
```

## Links

- [Home Manager](https://github.com/nix-community/home-manager)
- [Nixpkgs search](https://search.nixos.org/packages)
- [Home Manager options](https://home-manager-options.extranix.com/)
