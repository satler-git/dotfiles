{
  imports = [
    ./grimoire.nix
  ];
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
    waydroid.enable = true;
    oci-containers.backend = "docker";
    # vmware.host = {
    #   enable = true;
    #   extraConfig = ''
    #     mks.gl.allowUnsupportedDrivers = "TRUE"
    #     mks.vk.allowUnsupportedDevices = "TRUE"
    #   '';
    # };
    # TODO: i3とかX上じゃないとだめそう
    # virtualbox.host = {
    #   enable = true;
    #   enableKvm = true;
    #   addNetworkInterface = false;
    # };
  };
}
