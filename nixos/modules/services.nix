{
  inputs,
  ...
}:
{
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services = {
    hoogle = {
      enable = true;
      port = 8081;
      packages =
        hp: with hp; [
          lens
        ];
    };
    xremap = {
      userName = "satler";
      serviceMode = "system";
      config = {
        modmap = [
          {
            # CapsLockをCtrlに置換
            name = "CapsLock is dead";
            remap = {
              CapsLock = "Ctrl_L";
            };
          }
        ];
      };
    };
  };
}
