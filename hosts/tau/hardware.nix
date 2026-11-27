{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../modules/hardware/bluetooth.nix
    ../modules/hardware/printer.nix
    ../modules/hardware/xp-pen-pentab.nix

    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-e14-amd
  ];

  hardware.graphics = {
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
    ];
  };

  hardware.acpilight.enable = true;

  services.logind.settings.Login.HandleLidSwitch = "suspend"; # default

  # ファンを少し強めに回して CPU 温度を下げる。
  # 既定カーブは 60°C で level 7 (約 3700 rpm)、80°C 以上で EC の自動制御
  # (約 4000 rpm) に戻るため、76〜85°C 付近で回転が脈打っていた。
  # thinkpad_acpi の "level full-speed" は "disengaged" の別名で、EC の
  # 閉ループ制御を切って上限 (実測 約 6200 rpm) まで回すモード。
  # 常用は騒音・ファン負荷が大きいので、80°C 以上でのみ使う。
  # (80〜84°C はヒステリシス用の重なり)
  services.thinkfan = {
    enable = true;
    levels = [
      [ 0 0 55 ]
      [ 1 48 60 ]
      [ 2 50 61 ]
      [ 3 52 63 ]
      [ 6 56 65 ]
      [ 7 60 84 ]
      [ "level full-speed" 80 32767 ]
    ];
  };
  boot.kernelParams = [
    "thinkpad_acpi.fan_control=1"

    # Diagnostics for the s2idle -> black screen / no resume hangs.
    # "pm_debug_messages" logs every device suspend/resume step to dmesg,
    # and turning a stuck CPU / hung task into a panic makes efi_pstore keep
    # the trace so it can be read back after the forced reboot.
    "pm_debug_messages"
    "no_console_suspend"
    "softlockup_panic=1"
    "hardlockup_panic=1"
    "hung_task_panic=1"
    "panic=15"
  ];

  home-manager.sharedModules = [
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          "eDP-1, preferred, 0x0, 1.25"
        ];
      };
    }
    {
      programs.niri.settings.outputs = {
        "eDP-1" = {
          scale = 1.3;
        };
      };
    }
    {
      programs.yurf = {
        task = [
          {
            name = "brightnessctl: Increase by 10";
            command = "brightnessctl s +10";
          }
          {
            name = "brightnessctl: Decrease by 10";
            command = "brightnessctl s -10";
          }
          {
            name = "Open Bluetooth Manager";
            command = "blueman-manager";
          }
        ];
      };
    }
  ];
}
