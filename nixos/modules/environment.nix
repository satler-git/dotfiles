{ pkgs, config, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      dropbox-cli
      egl-wayland # TODO: maybe Nvidia here
      nvidia-vaapi-driver # TODO: Nvidia here
      polkit_gnome
    ];

    sessionVariables = rec {
      WEGORC = "${config.sops.templates.".wegorc".path}";
    };

    pathsToLink = [ "/share/zsh" ];
  };
}
