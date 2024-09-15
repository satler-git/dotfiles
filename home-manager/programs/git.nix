{
  # home.file = {
  #   ".gitconfig".source = ../../config/git/config;
  # };
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "mitsclatw24@mbr.nifty.com";
    userName = "satler-git";
    signing = {
      signByDefault = true;
      key = "97A7F4C53C4121DD";
    };
    extraConfig = {
      core = {
        editor = "nvim";
      };
      init.defaultBranch = "main";
      commit.verbose = true;
      ghq.root = "~/repos";
    };
  };
}
