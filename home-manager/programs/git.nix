{
  home.file.".gitmessage" = {
    text = builtins.replaceStrings [ "@comment@" ] [ "#" ] (
      builtins.readFile ../../config/git/gitmessage
    );
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    signing = {
      signByDefault = true;
      key = "1DB0252A735D5BAC";
    };
    ignores = [
      ".env"
      "*.swp"
      ".direnv/*"
      "memo.md"
      ".goosehints"
    ];
    settings = {
      user = {
        email = "satler@satler.dev";
        name = "satler";
      };
      core = {
        editor = "nvim";
      };
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      commit.verbose = true;
      commit.template = "~/.gitmessage";
      ghq.root = "~/repos";

      alias = {
        s = "status";
        d = "diff";
      };

      github.user = "satler-git"; # magit
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.lazygit = {
    enable = true;
  };
}
