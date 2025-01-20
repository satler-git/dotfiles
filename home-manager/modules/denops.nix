# https://github.com/ttak0422/denops-shared-server-service
# Copyright (c) 2024 Tak

{
  pkgs,
  lib,
  config,
  ...
}:
let
  inherit (lib) mkEnableOption mkOption types;
  cfg = config.my.services.denopsSharedServer;
in
{
  options = {
    my.services.denopsSharedServer = {
      enable = mkEnableOption "enable denops-shared-server";
      denoPackage = mkOption {
        type = types.package;
        default = pkgs.deno;
      };
      denops-vim-src = mkOption {
        type = types.package;
        default = pkgs.fetchFromGitHub {
          owner = "vim-denops";
          repo = "denops.vim";
          rev = "v7.0.4";
          sha256 = "sha256-vhWpRvdkVuFCBUwFCgm/pl2JQyGGYWSuXZbRIanXG+k=";
        };
      };
      port = mkOption {
        type = types.int;
        default = 32123;
      };
      hostName = mkOption {
        type = types.str;
        default = "127.0.0.1";
      };
      denoArgs = mkOption {
        type = with types; listOf str;
        default = [
          "-A"
          "--no-lock"
        ];
      };
      extraDenoArgs = mkOption {
        type = with types; listOf str;
        default = [ ];
      };
      cliPath = mkOption {
        type = types.str;
        default = "denops/@denops-private/cli.ts";
        description = "relative path to cli.ts";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.denops-shared-server = {
      Unit = {
        Description = "Denops Shared Server";
        Documentation = "https://github.com/vim-denops/denops.vim";
      };

      Install.WantedBy = [ "default.target" ];

      Service = {
        Type = "simple";
        Restart = "always";
        ExecStart =
          let
            denops-vim = pkgs.vimUtils.buildVimPlugin {
              pname = "denops-vim";
              version = cfg.denops-vim-src.rev;
              src = cfg.denops-vim-src;
            };
          in
          lib.strings.concatStringsSep " " (
            [
              "${lib.getExe cfg.denoPackage}"
              "run"
            ]
            ++ cfg.denoArgs
            ++ cfg.extraDenoArgs
            ++ [
              "${denops-vim}/${cfg.cliPath}"
              "--hostname=${cfg.hostName}"
              "--port=${toString cfg.port}"
            ]
          );
      };
    };
  };
}
