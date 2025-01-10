{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.my;
in
{
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
