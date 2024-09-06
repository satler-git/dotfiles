{ pkgs, ... }:
let
  packages = import ./pkgs.nix;
in
#  extPackages = import ./extraPkgs.nix;
{
  imports = [
    packages
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/wofi.nix
    ./programs/zsh.nix
    ./programs/waybar.nix
    ./services/dunst.nix
  ];
  programs.home-manager.enable = true;
  home = rec {
    username = "satler";
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    settings = import ./programs/hyprland.nix { inherit pkgs; };
  };
  home.sessionVariables = {
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
  };

  systemd.user.services = {
    ydotool = {
      Unit = {
        Description = "Starts ydotoold Daemon";
      };

      Service = {
        Type = "simple";
        Restart = "always";
        RestartSec = 3;
        ExecStartPre = "sleep 2";
        ExecStart = "${pkgs.ydotool}/bin/ydotoold";
        ExecReload = "kill -HUP $MAINPID";
        KillMode = "process";
        TimeoutSec = 180;
      };

      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };
}
