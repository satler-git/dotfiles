{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  home.file.zellij = {
    target = ".config/zellij/config.kdl";
    source = ../../config/zellij/config.kdl;
  };
}
