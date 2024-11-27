{ lib, ... }:
{
  services.udev.extraRules = lib.mkBefore ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="plugdev"
  '';
}
