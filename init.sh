#! /bin/bash

# Install Nix

sh <(curl -L https://nixos.org/nix/install) --daemon

# Add Nix experimental features

echo "experimental-features = nix-command flakes" | sudo tee -a /etc/nix/nix.conf
sudo systemctl restart nix-daemon.service

# Install Home Manager

nix run nixpkgs#gh -- auth login
nix run nixpkgs#gh -- repo clone 7kronos/dotfiles ~/dotfiles
nix run home-manager -- switch --flake ~/dotfiles/home#krs
