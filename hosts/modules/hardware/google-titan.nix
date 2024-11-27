{ lib, ... }:
{
  # Add support for google titan sec key
  # See also https://support.google.com/titansecuritykey/answer/9148044?hl=ja for more info
  services.udev.extraRules = lib.mkBefore ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="18d1|096e", ATTRS{idProduct}=="5026|0858|085b", TAG+="uaccess"
  '';
}
