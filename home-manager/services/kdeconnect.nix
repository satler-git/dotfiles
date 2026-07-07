{
  osConfig,
  lib,
  ...
}:
{
  services.kdeconnect = {
    enable = lib.mkDefault (osConfig.programs.kdeconnect.enable or false);
    indicator = true;
  };
}
