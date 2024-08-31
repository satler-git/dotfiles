{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
	};

	outputs = inputs:  {
		nixosConfigurations = {
			desktop = inputs.nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./nixos/configuration.nix
				];
			};
		};
	};
}
