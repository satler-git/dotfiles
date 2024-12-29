{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      epson-escpr
      epson-escpr2
    ];
  };
}
