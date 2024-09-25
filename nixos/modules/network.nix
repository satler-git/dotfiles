{
  networking = {
    hostName = "satlerdev"; # Define your hostname.

    # Enable networking
    networkmanager.enable = true;

    nameservers = [
      "8.8.8.8"
      "4.4.4.4"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [ 17500 ]; # 17500: Dropbox
      allowedUDPPorts = [
        17500
        57120
      ];
    };
  };
}
