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

    # hint for electron apps
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
