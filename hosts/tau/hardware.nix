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

  # CPU ファンのカーブ。
  # "level full-speed" (= disengaged) は 6200 rpm まで回るが、4000 rpm 比で
  # 数 °C しか変わらないわりに騒音が大きいので使わない。
  # 通常は level 7 (約 3700 rpm) で静かに回し、90°C を超えたときだけ EC の
  # 自動制御 (上限 約 4000 rpm) に任せる。86〜90°C の重なりはヒステリシス用。
  services.thinkfan = {
    enable = true;
    levels = [
      [ 0 0 55 ]
      [ 1 48 60 ]
      [ 2 50 61 ]
      [ 3 52 63 ]
      [ 6 56 65 ]
      [ 7 60 90 ]
      [ "level auto" 86 32767 ]
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
