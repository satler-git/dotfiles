{ pkgs, ... }:
let
  yazi-plugins-src = (pkgs.callPackages ../../_sources/generated.nix { }).yazi-plugins.src;
  yazi-compress-src = (pkgs.callPackages ../../_sources/generated.nix { }).yazi-compress.src;

  w = name: path: {
    inherit name path;
  };

  plugins = pkgs.linkFarm "yazi-plugins" [
    (w "chmod.yazi" "${yazi-plugins-src}/chmod.yazi")
    (w "full-border.yazi" "${yazi-plugins-src}/full-border.yazi")
    (w "git.yazi" "${yazi-plugins-src}/git.yazi")
    (w "compress.yazi" yazi-compress-src)
  ];

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

    settings = {
      open.prepend_rules = [
        {
          name = "*.html";
          use = [
            "open"
            "edit"
          ];
        }
      ];
      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
            for = "unix";
          }
        ];
      };
      plugin = {
        prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
    };

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
            "c"
            "p"
          ];
          run = "shell \"${print_command}\""; # lp -d
          desc = "Print out selected files";
        }
        {
          on = [
            "c"
            "g"
          ];
          run = "shell \"gh gist create $@\"";
          desc = "Create a gist that contains all selected files";
        }
        {
          on = [
            "c"
            "a"
          ];
          run = "plugin compress";
          desc = "Archive selected files";
        }
        {
          on = [
            "y"
          ];
          run = [
            "shell 'for path in \"$@\"; do echo \"file://$path\"; done | wl-copy -t text/uri-list'"
            "yank"
          ];
          desc = "Yank(Also yank in the system clipboard)";
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
