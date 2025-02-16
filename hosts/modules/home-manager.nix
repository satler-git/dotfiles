{ inputs, self, ... }:
{
  home-manager = {
    extraSpecialArgs = {
      inherit inputs self;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };
}
