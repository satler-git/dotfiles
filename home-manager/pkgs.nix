{ pkgs, inputs, ... }:
let
  superdirt-install = inputs.tidalcycles.packages.x86_64-linux.superdirt-install;
in
{
  imports = [
    ./pkgs/chromium.nix
    ./pkgs/trane-cli.nix
    ./pkgs/cargo-compete.nix
  ];

  home.packages =
    with pkgs;
    [
      act
      alacritty-theme
      anki-bin
      # ardour
      aria
      aseprite
      # audacity

      # blender
      bat
      bibata-cursors
      bottom
      buf
      delta
      difftastic

      cabal-install
      # calibre # disable temp FIXME
      clipse

      deno
      difftastic
      duckdb
      duf
      dust

      # element-desktop
      elixir_1_16
      eva
      evcxr
      eza

      fd
      ffmpeg_7-full
      foliate
      fzf

      gcc
      gh
      ghc
      ghq
      ghq
      gimp
      # gitbutler
      gnumake
      graalvm-ce
      gst_all_1.gst-plugins-bad
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-ugly

      haskell-language-server
      haskellPackages.hoogle
      haskellPackages.tidal

      ihp-new
      imhex
      inkscape

      jq
      # jujutsu
      just

      k9s
      kalker
      # kicad
      koreader
      krita

      libsForQt5.xp-pen-deco-01-v2-driver
      libsForQt5.xwaylandvideobridge
      lmms
      luajit
      lutris

      mindustry-wayland
      mpv

      nb
      nix-your-shell
      # numbat

      p7zip
      pandoc
      peazip
      playerctl
      # pureref

      # spacedrive
      src-cli
      stack
      stylish-haskell
      stylua
      sunvox
      supercollider-with-sc3-plugins

      tetrio-desktop
      thunderbird
      tre-command
      treefmt
      typst

      ueberzugpp
      unzip
      uxn

      obs-studio
      osu-lazer-bin
      oxker

      ripgrep
      ripgrep-all
      reversal-icon-theme
      rustup

      hledger

      vlc

      # wireshark
      wl-clipboard
      # wolfram-engine

      grim # for screenshot in wayland
      slurp

      xclip
      xh

      yazi

      zola
      zoom-us
      zoxide
      zrythm
    ]
    ++ [
      superdirt-install
    ];
}
