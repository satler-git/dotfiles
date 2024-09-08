{
  home.file = {
    ".zshrc".source = ../../config/zsh/zshrc;
  };
  programs.zsh = {
    enable = true;
    initExtra = ''
      eval "$(zoxide init zsh)"
    '';
  };
}
