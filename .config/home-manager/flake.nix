{
  description = "Home Manager configuration of toni";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      systems = [ "x86_64-linux" "aarch64-darwin" ];
    in {
    packages = nixpkgs.lib.genAttrs systems (system: {
      home-manager = home-manager.packages.${system}.default;
    });

    homeConfigurations."toni" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs {
        system = builtins.currentSystem;
      };
      modules = [ ./home.nix ];
    };
  };
}
