{
  description = "Home Manager configuration of kronos";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations = {
        "krs@BATTLESTAR" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ 
            ./targets/warp.nix
            ./home.nix
            ./shell.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
        "kronos@KRSBOOK" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [ 
            ./targets/book.nix
            ./home.nix
            ./shell.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };

      programs.zsh.enable = true;
      users.users.krs.shell = pkgs.zsh;
      environment.shells = with pkgs; [ zsh ];

      programs.ssh.startAgent = true;
    };
}
