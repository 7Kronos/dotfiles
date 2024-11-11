# Tarik's NixOS Setup

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
