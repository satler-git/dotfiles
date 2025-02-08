{
  inputs,
  ...
}:
{
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services.xremap = {
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
}
