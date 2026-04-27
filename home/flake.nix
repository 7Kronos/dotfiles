{
  description = "Home Manager configuration of Tarik";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config = { allowUnfree = true; }; };

      mkHome = { username, homeDirectory }: home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          {
            home.username = username;
            home.homeDirectory = homeDirectory;
            home.stateVersion = "25.05";
          }
          ./home.nix
          ./shell.nix
        ];
      };
    in {
      homeConfigurations = {
        "krs@BATTLESTAR"  = mkHome { username = "krs";    homeDirectory = "/home/krs"; };
        "kronos@KRS"      = mkHome { username = "kronos"; homeDirectory = "/home/kronos"; };
        "kronos@KRSBOOK"  = mkHome { username = "kronos"; homeDirectory = "/home/kronos"; };
        "admin@klaw"      = mkHome { username = "admin";  homeDirectory = "/home/admin"; };
      };
    };
}
