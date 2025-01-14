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

  home-manager = {
    users.satler = ../../../home-manager/linux.nix;
  };
}
