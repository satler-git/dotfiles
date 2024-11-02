{
  description = "My dotfiles for Nixos";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    tidalcycles = {
      url = "github:mitchmindtree/tidalcycles.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "stylix/flake-utils";
      inputs.crane.follows = "xremap/crane";
    };
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
      inputs.flake-compat.follows = "neovim-nightly-overlay/flake-compat";
    };
    xremap = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.treefmt-nix.follows = "treefmt-nix";
      inputs.home-manager.follows = "home-manager";
      inputs.flake-parts.follows = "neovim-nightly-overlay/flake-parts";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      tidalcycles,
      neovim-nightly-overlay,
      treefmt-nix,
      systems,
      zjstatus,
      stylix,
      xremap,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        neovim-nightly-overlay.overlays.default
        (final: prev: {
          zjstatus = zjstatus.packages.${prev.system}.default;
        })
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system;
        inherit overlays;
      };

      treefmtEval = treefmt-nix.lib.evalModule pkgs ./treefmt.nix;
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            stylix.nixosModules.stylix
            xremap.nixosModules.default
            ./nixos
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = overlays;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.satler = import ./home-manager/linux.nix { inherit pkgs inputs; };
            }
          ];
        };
      };
      formatter.x86_64-linux = treefmtEval.config.build.wrapper;

      checks.x86_64-linux = {
        format = treefmtEval.config.build.wrapper;
      };
    };
}
