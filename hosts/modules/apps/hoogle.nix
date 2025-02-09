{ lib, ... }:
{
  services = {
    hoogle = {
      enable = true;
      port = lib.mkDefault 8081;
      packages =
        hp: with hp; [
          lens
        ];
    };
  };
}
