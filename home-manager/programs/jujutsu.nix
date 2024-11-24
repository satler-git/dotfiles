{ pkgs, lib, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "mitsclatw24@mbr.nifty.com";
      user.name = "satler-git";
      core = {
        fsmonitor = "watchman";
      };
      template-aliases = {
        "format_short_id(id)" = "id.shortest()";
        "commit_style_desc" = ''"${
          builtins.replaceStrings [ "@comment@" ] [ "JJ:" ] (builtins.readFile ./git/gitmessage)
        }"'';
      };
      templates = {
        draft_commit_description = ''
          concat(
            description,
            commit_style_desc,
            surround(
              "\nJJ: This commit contains the following changes:\n", "",
              indent("JJ:     ", diff.stat(72)),
            ),
          )
        '';
      };
      ui = {
        paginate = "never";
        editor = "nvim";
        diff = {
          format = "git";
          tool = [
            "${lib.getExe pkgs.delta}"
            "--no-gitconfig"
            "--color-only"
            "$left"
            "$right"
          ];
        };
        signing = {
          sign-all = true;
          backend = "gpg";
          key = "97A7F4C53C4121DD";
        };
      };
    };
  };
}
