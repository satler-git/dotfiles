{ pkgs, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      dropbox-cli
      egl-wayland # TODO: maybe Nvidia here
      nixfmt-rfc-style
      nvidia-vaapi-driver # TODO: Nvidia here
      polkit_gnome
    ];

    pathsToLink = [ "/share/zsh" ];
  };
}
