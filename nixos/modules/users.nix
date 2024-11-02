{ pkgs, ... }:
{
  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.satler = {
      isNormalUser = true;
      description = "satler";
      extraGroups = [
        "audio"
        "docker"
        "input"
        "networkmanager"
        "plugdev"
        "vboxusers"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };
}
