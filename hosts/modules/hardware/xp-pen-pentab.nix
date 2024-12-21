{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libsForQt5.xp-pen-deco-01-v2-driver
  ];
}
