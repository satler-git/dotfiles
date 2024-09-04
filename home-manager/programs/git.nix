{
  home.file = {
    ".gitconfig".source = ../../config/git/config;
  };
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
}
