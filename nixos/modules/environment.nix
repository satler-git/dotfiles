{ pkgs, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      alacritty
      dropbox-cli
      egl-wayland
      eza
      nixfmt-rfc-style
      nvidia-vaapi-driver
      wget
      wine
      polkit_gnome
    ];

  };
}
