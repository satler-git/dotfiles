{
  programs = {
    firefox.enable = true;
    git.enable = true;
    hyprland.enable = true;
    nix-ld.enable = true;
    starship.enable = true;
    vim.enable = true;
    zsh.enable = true;

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    nh = {
      enable = true;
      flake = "/home/satler/dotfiles";
    };
  };
}
