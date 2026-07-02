{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xppen_3
    xppen_4
  ];
}
