{ pkgs, config, ... }:
{
  environment = {

    systemPackages = with pkgs; [
      dropbox-cli
      egl-wayland # TODO: maybe Nvidia here
      nvidia-vaapi-driver # TODO: Nvidia here
      polkit_gnome
    ];

    sessionVariables = {
      WEGORC = "${config.sops.templates.".wegorc".path}";

      QT_IM_MODULE = "${config.i18n.inputMethod.type}";
    };

    pathsToLink = [ "/share/zsh" ];
  };
}
