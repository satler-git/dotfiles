{ pkgs, lib, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "satler@satler.dev";
      user.name = "satler";
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
            "\nJJ: This commit contains the following changes:\n",
            indent("JJ:     ", diff.stat(72)),
          )
        '';
      };
      ui = {
        paginate = "never";
        default-command = "log";
        editor = "nvim";
        movement.edit = true;
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
      };
      aliases = {
        stat = [
          "show"
          "--stat"
        ];
        fulllog = [
          "log"
          "-r"
          "root()::"
        ];
        llog = [
          "log"
          "-r"
          "main@origin.."
        ];
        d = [ "desc" ];
        pushmain = [
          "util"
          "exec"
          "--"
          "${pkgs.writeShellScript "pushmain" ''
            log_output=$(jj log --no-graph --template 'change_id ++ "\n"' -r 'bookmarks() & (main..@)')

            if [ -n "$bookmark_commits" ]; then
              echo "Changes with bookmarks tied to bookmarks other than main exist between main and the current change."
              echo "pushmain has canceled"
            else
              jj bookmark m --to @- main && jj git push
            fi
          ''}"
        ];
        inittrack = [
          "util"
          "exec"
          "--"
          "${pkgs.writeShellScript "pushmain" ''
            jj git init --colocate && jj bookmark track main@origin
          ''}"
        ];
      };
      fix.tools = {
        nixfmt = {
          command = [
            "nix"
            "fmt"
          ];
          patterns = [ "glob:**/*.*" ];
        };
      };
      signing = {
        behavior = "own";
        backend = "gpg";
        key = "1DB0252A735D5BAC";
      };
    };
  };
}
