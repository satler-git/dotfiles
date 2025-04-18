{ pkgs, inputs, ... }:
{
  imports = [
    ./pkgs/chromium.nix
  ];

  home.packages = with pkgs; [
    # audacity
    aria

    blender
    bottom

    calibre
    charm-freeze
    claude-code
    code-cursor

    deno
    delta
    duckdb
    duf
    dust

    evcxr

    fd
    ffmpeg_7-full
    foliate
    fzf

    gh
    ghq
    gimp
    gnumake
    gnutar
    go-task
    graalvm-ce
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly
    gst_all_1.gstreamer

    imhex
    inkscape
    inputs.isd.packages.${system}.default
    inputs.yurf.packages.${system}.default

    jq

    kicad
    koreader
    krita

    lnav
    lutris

    mindustry-wayland
    mission-center
    mpv

    nix-init
    nix-output-monitor
    nix-update
    nix-your-shell
    nomacs
    numbat

    p7zip
    pandoc
    playerctl
    podman-compose
    prismlauncher
    pympress

    smartmontools
    spotify

    teip
    tetrio-desktop
    thunderbird
    todoist
    todoist-electron
    trash-cli
    tre-command
    typos
    typst
    typst-live

    ueberzugpp
    unzip

    obs-studio
    osu-lazer-bin

    rdfind
    ripgrep
    ripgrep-all
    rquickshare

    hledger
    hyperfine

    vlc

    # wireshark
    wakatime-cli
    watchman
    webcord-vencord
    wget

    xh

    yazi

    zip
    zoom-us
    zoxide
  ];
}
