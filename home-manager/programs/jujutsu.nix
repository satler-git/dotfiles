{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "mitsclatw24@mbr.nifty.com";
      user.name = "satler-git";
      ui = {
        paginate = "never";
        editor = "nvim";
        diff = {
          format = "git";
          tool = [ "delta" " --true-color" "--no-gitconfig" "$left" "$right"];
        };
      };
    };
  };
}
