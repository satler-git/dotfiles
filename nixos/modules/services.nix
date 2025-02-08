{
  inputs,
  ...
}:
{
  services = {
    hoogle = {
      enable = true;
      port = 8081;
      packages =
        hp: with hp; [
          lens
        ];
    };
  };
}
