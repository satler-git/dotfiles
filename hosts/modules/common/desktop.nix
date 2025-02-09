{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./common.nix
  ];

  hardware.graphics = {
    enable = lib.mkDefault true;
  };

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;

  documentation = {
    man = {
      enable = true;
      man-db.enable = true;
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      # fcitx5-mozc
      fcitx5-gtk
      fcitx5-mozc-ut
      fcitx5-tokyonight
    ];
    fcitx5.waylandFrontend = true;
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  security.rtkit.enable = true;

  environment = {
    sessionVariables = {
      QT_IM_MODULE = "${config.i18n.inputMethod.type}";
    };

    pathsToLink = [ "/share/zsh" ];

    localBinInPath = true;
  };
}
