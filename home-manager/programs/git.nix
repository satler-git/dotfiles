{
  home.file.".gitmessage" = {
    text = builtins.replaceStrings [ "@comment@" ] [ "#" ] (
      builtins.readFile ../../config/git/gitmessage
    );
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "satler@satler.dev";
    userName = "satler";
    signing = {
      signByDefault = true;
      key = "1DB0252A735D5BAC";
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".env"
      "*.swp"
      ".direnv/*"
      "memo.md"
      ".goosehints"
    ];
    aliases = {
      s = "status";
      d = "diff";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      commit.verbose = true;
      commit.template = "~/.gitmessage";
      ghq.root = "~/repos";

      github.user = "satler-git"; # magit
    };
  };

  programs.lazygit = {
    enable = true;
  };
}
