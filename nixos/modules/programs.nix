{
  programs = {
    firefox.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
    vim.enable = true;
    zsh.enable = true;
    localsend.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  };
}
