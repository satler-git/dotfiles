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
    virtualbox.host = {
      enable = true;
    };
  };
}
