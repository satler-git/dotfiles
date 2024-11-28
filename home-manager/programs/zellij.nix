{ pkgs, ... }:
let
  sources = (pkgs.callPackages ../../_sources/generated.nix { });
  zellij-room = sources.zellij-room;
  zellij-zj-quit = sources.zellij-zj-quit;
in
{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  xdg.configFile = {
    zellij-main = {
      target = "zellij/config.kdl";
      source = pkgs.substituteAll {
        src = ../../config/zellij/config.kdl;
        zj_quit_location = "${zellij-zj-quit.src}";
        room_location = "${zellij-room.src}";
      };
    };
    zellij-layout-default = {
      target = "zellij/layouts/default.kdl";
      source = pkgs.substituteAll {
        src = ../../config/zellij/layouts/default.kdl;
        zjstatus_location = "${pkgs.zjstatus}/bin/zjstatus.wasm";
      };
    };
  };
}
