{
  networking = {
    hosts = {
      "0.0.0.0" = [
        # "x.com"
        # "twitter.com"
      ];
    };

    networkmanager.enable = true;

    nameservers = [
      "8.8.8.8"
      "4.4.4.4"
    ];

    firewall = {
      enable = true;
      allowedTCPPorts = [
        17500 # Dropbox
        8080 # Hoogle
      ];
      allowedUDPPorts = [
        17500 # Dropbox
        57120 # SuperColider
      ];
    };
  };
}
