{
  inputs,
  ...
}:
{
  imports = [
    inputs.xremap.nixosModules.default
  ];

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
    };
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
  security.rtkit.enable = true;
}
