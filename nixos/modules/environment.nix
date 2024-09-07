{ pkgs, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      alacritty
      chromium
      dropbox-cli
      egl-wayland
      eza
      nixfmt-rfc-style
      nvidia-vaapi-driver
      wget
      wine
    ];

    # hint for electron apps
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
