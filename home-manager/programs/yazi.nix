{ pkgs, ... }:
let
  yazi-plugins-src = (pkgs.callPackages ../../_sources/generated.nix { }).yazi-plugins.src;

  w =
    name: src:
    pkgs.runCommand "${name}" { } ''
      mkdir -p $out/${name}
      cp -r ${src}/* $out/${name}
    '';

  plugins = pkgs.symlinkJoin {
    name = "yazi-plugins";
    paths = [
      (w "chmod.yazi" "${yazi-plugins-src}/chmod.yazi")
      (w "full-border.yazi" "${yazi-plugins-src}/full-border.yazi")
    ];
  };

  printer_name = "EPSON_EP-705A_Series"; # TODO: printer selector
  print_command = "lp -d ${printer_name} $@";
in
{
  home.packages = with pkgs; [
    exiftool
  ];

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    keymap = {
      manager.prepend_keymap = [
        {
          on = [
            "c"
            "m"
          ];
          run = "plugin chmod";
          desc = "Chmod on selected files";
        }
        {
          on = [
            "p" # Shell command prefix
            "p"
          ];
          run = "shell \"${print_command}\""; # lp -d
          desc = "Print out selected files";
        }
      ];
    };
  };

  ## Plugins
  xdg.configFile = {
    "yazi/plugins" = {
      source = plugins;
      recursive = true;
    };
    "yazi/init.lua" = {
      source = ../../config/yazi/init.lua;
    };
  };
}
