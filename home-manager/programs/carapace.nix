{
  programs.carapace = {
    enable = true;
  };
  home.sessionVariables = {
    CARAPACE_MATCH = "1";
    CARAPACE_EXCLUDES = "tar,gpg";
    CARAPACE_BRIDGES = "zsh";
  };

  xdg.configFile."carapace/specs" = {
    source = ../../config/completions;
    recursive = true;
  };
}
