{ pkgs, lib, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "satler@satler.dev";
      user.name = "satler";
      fsmonitor.backend = "watchman";

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

        pager = "delta";
        diff-formatter = ":git";

        diff-editor = ":builtin";
      };

      merge-tools.delta.diff-expected-exit-codes = [
        0
        1
      ];

      aliases = {
        d = [ "desc" ];
        n = [ "new" ];
        nb = [
          "new"
          "--insert-before"
          "@"
        ];
        s = [ "squash" ];

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
        push = [
          "util"
          "exec"
          "--"
          "${pkgs.writeShellScript "pushmain" ''
            jj tug && jj git push
          ''}"
        ];
        pch = [
          "git"
          "push"
          "--change"
          "@-"
        ];
        inittrack = [
          "util"
          "exec"
          "--"
          "${pkgs.writeShellScript "pushmain" ''
            jj git init --colocate && jj bookmark track main@origin
          ''}"
        ];
        fe = [
          "git"
          "fetch"
        ];
        tug = [
          "bookmark"
          "move"
          "--from"
          "heads(::@- & bookmarks())"
          "--to"
          "@-"
        ]; # pushmainの代わりに使えそう
        fetch-all = [
          "git"
          "fetch"
          "all-remotes"
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
