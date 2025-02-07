{ pkgs, ... }:
{
  users = {
    users.satler = {
      isNormalUser = true;
      description = "satler";
      extraGroups = [
        "audio"
        "docker"
        "input"
        "uinput"
        "networkmanager"
        "wheel"
        "plugdev"
      ];
      shell = pkgs.zsh;
    };
  };

  nix.settings.trusted-users = [
    "satler"
  ];

  home-manager = {
    users.satler = ../../../home-manager/linux.nix;
  };
}
