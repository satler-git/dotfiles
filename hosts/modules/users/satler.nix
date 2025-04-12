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
        "networkmanager"
        "plugdev"
        "podman"
        "uinput"
        "video"
        "wheel"
      ];
      shell = pkgs.zsh;

      initialHashedPassword = "$y$j9T$jrEwC7ZZUCFpS16P4/3l0/$4nLI6Jn5rqjE3dJ702AcPJPPvP6GRMvFMqH3on4FCm4";
    };
  };

  nix.settings.trusted-users = [
    "satler"
  ];

  home-manager = {
    users.satler = ../../../home-manager/linux.nix;
  };
}
