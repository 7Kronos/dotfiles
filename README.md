# Tarik's NixOS Setup

## Install Nix

```sh
sh <(curl -L https://nixos.org/nix/install) --daemon

# Add Nix experimental features

echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
sudo systemctl restart nix-daemon.service
```

## Home Manager

```sh
nix-shell -p home-manager
```
## Init configuration

```sh
nix run home-manager -- switch --flake ~/dotfiles/home#krs
```

## Garbage collection

```sh
nix-collect-garbage
```

## Update packages

```sh
nix flake update
```

# Links

## Packages

- [Home Manager](https://github.com/nix-community/home-manager)
- [NixHub](https://www.nixhub.io/)
