{
  lib,
  config,
  ...
}:
let
  cfg = config.my;
in
{
  imports = [
    ./boot.nix
    ./network.nix
  ];

  options.my = {
    hostName = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
    };
  };

  config = {
    programs = {
      git.enable = true;
      vim.enable = true;
      zsh.enable = true;
    };

    time.timeZone = "Asia/Tokyo";

    networking.hostName = cfg.hostName;
  };
}
