{
  imports = [
    # keep-sorted start
    ../modules/apps/dropbox.nix
    ../modules/apps/hoogle.nix
    ../modules/apps/i3.nix
    ../modules/apps/libvirt.nix
    ../modules/apps/llm.nix
    ../modules/apps/podman.nix
    ../modules/apps/tailscale.nix
    ../modules/apps/wego.nix
    # ../modules/apps/openhands.nix
    # keep-sorted end
  ];

  my.openFirewall = true;

  my.services.dropbox.enable = true;

  # my.services.openhands = {
  #   enable = true;
  #   extraRuntimePackages = with pkgs; [
  #     buildPackages.stdenv.cc
  #     (fenix.combine [
  #       fenix.stable.toolchain
  #     ])
  #   ];
  # };
  # べつにいらないというかうまくできない

  programs = {
    # keep-sorted start

    firefox.enable = true;
    hyprland.enable = true;
    localsend.enable = true;
    steam = {
      remotePlay.openFirewall = true;
      enable = true;
    };
    # keep-sorted end
  };
}
