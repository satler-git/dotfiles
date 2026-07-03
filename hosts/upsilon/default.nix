{
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{
  # nix-on-droid has no built-in hostName option, so set it via env + /etc/hostname.
  environment.sessionVariables.HOSTNAME = "upsilon";
  environment.etc."hostname".text = "upsilon";

  environment.etcBackupExtension = ".bak";

  system.stateVersion = "24.05"; # Don't change this

  time.timeZone = "Asia/Tokyo";

  user = {
    userName = "satler";
    group = "satler";
    shell = "${pkgs.zsh}/bin/zsh";
  };

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  home-manager = {
    config = ../../home-manager/droid.nix;
    backupFileExtension = "hm-bak";
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs self;
    };
  };
}
