{ lib, inputs, ... }:
{
  imports = [
    inputs.aagl.nixosModules.default

    # keep-sorted start
    ../modules/apps/dropbox.nix
    ../modules/apps/hoogle.nix
    ../modules/apps/i3.nix
    ../modules/apps/libvirt.nix
    ../modules/apps/llm.nix
    ../modules/apps/obs-studio.nix
    ../modules/apps/podman.nix
    ../modules/apps/syncthing.nix
    ../modules/apps/tailscale.nix
    ../modules/apps/wego.nix
    # keep-sorted end
  ];

  my.openFirewall = true;

  my.services.dropbox.enable = true;

  services.tailscale = {
    useRoutingFeatures = "both";

    extraUpFlags = lib.mkAfter [
      "--advertise-exit-node"
    ];
  };

  programs = {
    # keep-sorted start
    firefox.enable = true;
    hyprland.enable = true;
    localsend.enable = true;
    # keep-sorted end

    # gaming
    steam = {
      remotePlay.openFirewall = true;
      enable = true;
    };
    sleepy-launcher.enable = true;
  };
}
