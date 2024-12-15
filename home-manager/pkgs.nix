{ pkgs, inputs, ... }:
let
  superdirt-install = inputs.tidalcycles.packages.x86_64-linux.superdirt-install;
in
{
  imports = [
    ./pkgs/chromium.nix
    ./pkgs/cargo-compete.nix
    ./pkgs/anki.nix
  ];

  home.packages =
    with pkgs;
    [
      # ardour
      # audacity
      age
      alacritty
      aria

      # blender
      bat
      bibata-cursors
      bottom
      btop
      buf

      calibre
      cabal-install
      cargo-nextest
      chafa
      # cinny-desktop # Insecure
      clipse

      deno
      delta
      difftastic
      dive
      duckdb
      duf
      dust

      elixir_1_16
      eva
      evcxr
      eza

      fd
      ffmpeg_7-full
      foliate
      fzf

      # gitbutler
      gcc
      gh
      ghc
      ghq
      gimp
      gnumake
      gnutar
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
      # just

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

      nix-output-monitor
      nix-your-shell
      nix-init
      nix-update
      # numbat

      p7zip
      pandoc
      peazip
      playerctl
      podman-compose
      podman-desktop
      podman-tui
      # pureref

      # spacedrive
      sops
      spotify
      stack
      sunvox
      supercollider-with-sc3-plugins
      superfile

      tetrio-desktop
      thunderbird
      tig
      tre-command
      treefmt
      typst

      ueberzugpp
      unzip

      osu-lazer-bin
      oxker

      reversal-icon-theme
      ripgrep
      ripgrep-all
      rr
      rustup

      hledger

      vlc
      vimgolf
      vim

      # wireshark
      # wolfram-engine
      wakatime-cli
      watchman
      webcord-vencord
      wego
      wget
      wl-clipboard

      grim # for screenshot in wayland
      slurp

      xclip
      xh

      yazi

      zoom-us
      zoxide
    ]
    ++ [
      superdirt-install
    ];
}
