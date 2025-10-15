{ osConfig, ... }:
{
  programs.halloy = {
    enable = true;

    settings = {
      buffer.channel = {
        topic = {
          enabled = true;
        };
        nicklist = {
          width = 200;
        };
      };

      servers.liberachat = {
        channels = [
          "NickServ"
          "MemoServ"

          "##anime"
          "##chat"
          "##japanese"
          "##math"
          "##programming"
          "##puzzle"

          "#halloy"

          "#nixos"

          "#lobsters"

          "#emacs"
          "#vim"
          "#neovim"

          "##rust"
          "#haskell"
          "#lean"
        ];
        nickname = "satler";
        server = "irc.libera.chat";

        sasl.plain = {
          username = "satler";
          password_file = osConfig.sops.secrets.irc_satler.path;
        };
      };

      keyboard = {
        move_up = "alt+k";
        move_down = "alt+j";
        move_left = "alt+h";
        move_right = "alt+l";
      };

      font.family = "IBM Plex Sans JP";
    };
  };
}
