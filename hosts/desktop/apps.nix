{
  imports = [
    ../modules/apps/dropbox.nix
    ../modules/apps/i3.nix
    ../modules/apps/libvirt.nix
    ../modules/apps/llm.nix
    ../modules/apps/wego.nix
  ];

  my.services.dropbox.enable = true;

  programs = {
    firefox.enable = true;
    localsend.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    hyprland.enable = true;
  };
}
