{
  programs.neovim = {
    enable = true;
  };
  home.file = {
    ".config/nvim/"= {
      target = ".config/nvim";
      source = ../../config/nvim;
      recursive = true;
    };
  };
}
