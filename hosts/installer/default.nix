{

  self,
  pkgs,
  modulesPath,
  inputs,
  lib,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-graphical-gnome.nix")
    (modulesPath + "/installer/cd-dvd/channel.nix")
  ];

  services.xserver.xkb.layout = "jp";

  programs = {
    # keep-sorted start
    git.enable = true;
    localsend.enable = true;
    neovim.enable = true;
    nix-ld.enable = true;
    zsh.enable = true;
    # keep-sorted end
  };

  time.timeZone = "Asia/Tokyo";

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  networking.hostName = "iso";

  environment.systemPackages =
    with pkgs;
    [
      inputs.disko.packages.${pkgs.system}.default

      alacritty
    ]
    ++ self.devShells.x86_64-linux.default.buildInputs;

  systemd.services.clone-dotfiles = {
    description = "Clone dotfiles into /home/nixos/dotfiles";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.git} clone https://github.com/satler-git/dotfiles.git /home/nixos/self || true";
    };

    serviceConfig.User = "nixos";
    serviceConfig.Group = "nixos";
  };
}
