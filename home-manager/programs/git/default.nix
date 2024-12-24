{
  home.file.".gitmessage" = {
    text = builtins.replaceStrings [ "@comment@" ] [ "#" ] (builtins.readFile ./gitmessage);
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "mitsclatw24@mbr.nifty.com";
    userName = "satler-git";
    signing = {
      signByDefault = true;
      key = "97A7F4C53C4121DD";
    };
    delta = {
      enable = true;
    };
    ignores = [
      ".env"
      "*.swp"
      ".direnv/*"
      "memo.md"
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
    };
  };
  programs.lazygit = {
    enable = true;
  };
}
