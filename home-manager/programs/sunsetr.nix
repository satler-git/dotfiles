{ pkgs, inputs, ... }:
{
  home.packages = [
    (inputs.sunsetr.packages.${pkgs.system}.sunsetr.overrideAttrs {
      doCheck = false;
    })
  ];

  xdg.configFile = {
    "sunsetr/sunsetr.toml".source = pkgs.writers.writeTOML "sunsetr.toml" {
      backend = "auto";
      transition_mode = "geo";

      smoothing = true;
      startup_duration = 0.5;
      shutdown_duration = 0.5;
      adaptive_interval = 1;

      night_temp = 3300;
      day_temp = 6500;
      night_gamma = 90;
      day_gamma = 100;
      update_interval = 60;
    };
    "sunsetr/presets/day/sunsetr.toml".source = pkgs.writers.writeTOML "day-sunsetr.toml" {
      backend = "auto";
      transition_mode = "static";

      smoothing = true;
      startup_duration = 0.5;
      shutdown_duration = 0;
      adaptive_interval = 1;

      static_temp = 6500;
      static_gamma = 100;
    };
  };
}
