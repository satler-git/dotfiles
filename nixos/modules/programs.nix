{
  programs = {
    firefox.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
    localsend.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
