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

      git = {
        colocate = true;
        write-change-id-header = true;
      };

      template-aliases = {
        "format_short_id(id)" = "id.shortest()";
        "commit_style_desc" = ''"${
          builtins.replaceStrings [ "@comment@" ] [ "JJ:" ] (builtins.readFile ./git/gitmessage)
        }"'';
        "in_branch(commit)" = "commit.contained_in(\"immutable_heads()..bookmarks()\")";
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
        log_node = ''
          if(self && !current_working_copy && !immutable && !conflict && in_branch(self),
            "◇",
            builtin_log_node
          )
        '';
      };
      revset-aliases = {
        "p(n)" = "p(@, n)";
        "p(r, n)" = "roots(r | ancestors(r-, n))";
        "user(x)" = "author(x) | committer(x)";
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
        n = [ "new" ];
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
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ]; # pushmainの代わりに使えそう
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
