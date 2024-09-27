let
  config = import ./config.nix;
in
{
  xsession.windowManager.i3 = {
    enable = true;
    inherit config;
  };
}
