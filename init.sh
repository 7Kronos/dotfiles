#! /bin/bash

nix run nixpkgs#gh -- auth login
nix run nixpkgs#gh -- repo clone 7kronos/dotfiles ~/dotfiles
nix run home-manager -- switch --flake ~/dotfiles/home#krs
