{ pkgs, ... }:
{
  users = {
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.satler = {
      isNormalUser = true;
      description = "satler";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "input"
        "audio"
        "vboxusers"
      ];
      shell = pkgs.zsh;
    };
  };
}
