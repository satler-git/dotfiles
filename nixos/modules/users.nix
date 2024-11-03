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
        "uinput"
        "networkmanager"
        "vboxusers"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
    groups = {
      plugdev = {
        members = [
          "satler"
        ];
      };
    };
  };
}
