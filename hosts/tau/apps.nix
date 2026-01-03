# { ... }:
{
  imports = [
    # keep-sorted start
    # ../modules/apps/dropbox.nix
    ../modules/apps/i3.nix
    ../modules/apps/podman.nix
    ../modules/apps/tailscale.nix
    # keep-sorted end
  ];

  my.openFirewall = false;

  # my.services.dropbox.enable = true;

  services.tailscale = {
    useRoutingFeatures = "both";
  };

  programs = {
    # keep-sorted start
    firefox.enable = true;
    hyprland.enable = true;
    immersed.enable = true;
    light.enable = true;
    localsend.enable = true;
    niri.enable = true;
    steam.enable = true;
    # keep-sorted end
  };
}
