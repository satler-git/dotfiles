{
  programs.irssi = {
    enable = true;
    networks = {
      liberachat = {
        nick = "satler";
        server = {
          address = "irc.libera.chat";
          port = 6697;
          autoConnect = true;
        };
        channels = {
          # nixos.autoJoin = true;
        };
      };
    };
  };
}
