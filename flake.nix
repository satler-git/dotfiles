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
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      tidalcycles,
      neovim-nightly-overlay,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      overlays = [
        neovim-nightly-overlay.overlays.default
      ];
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        inherit system;
        inherit overlays;
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
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
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
