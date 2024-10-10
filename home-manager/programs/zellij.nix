{ pkgs, ... }:
let
  sources = (pkgs.callPackages ../../_sources/generated.nix {});
  zellij-room = sources.zellij-room;
  zellij-zj-quit = sources.zellij-zj-quit;
in{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
  };
  home.file = {
    zellij-main = {
      target = ".config/zellij/config.kdl";
      source = pkgs.substituteAll {
        src = ../../config/zellij/config.kdl;
        zj-quit_location = "${zellij-zj-quit.src}";
        room_location = "${zellij-room.src}";
      };
    };
    zellij-layout-default = {
      target = ".config/zellij/layouts/default.kdl";
      source = pkgs.substituteAll {
        src = ../../config/zellij/layouts/default.kdl;
        zjstatus_location = "${pkgs.zjstatus}/bin/zjstatus.wasm";
      };
    };
  };
}
