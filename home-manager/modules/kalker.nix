{
  lib,
  config,
  pkgs,
  ...
}:
let
  cfg = config.my.programs.kalker;
in
{
  options.my.programs.kalker = {
    enable = lib.mkEnableOption "Enable Kalker";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.kalker;
      defaultText = lib.literalExpression "pkgs.kalker";
      description = "The Kalker package to install.";
    };

    setting = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
    };

    angle_unit = lib.mkOption {
      type = lib.types.enum [
        "rad"
        "deg"
      ];
      default = "deg";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."kalker/default.kalker" = lib.mkIf (cfg.setting != null) {
      text = cfg.setting;
    };
  };
}
