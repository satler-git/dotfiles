{ pkgs, inputs, ... }:
let
  superdirt-install = inputs.tidalcycles.packages.x86_64-linux.superdirt-install;
in
{
  imports = [
    ./pkgs/chromium.nix
  ];

  home.packages = with pkgs; [
    alacritty-theme
    anki-bin
    ardour
    aria
    aseprite
    audacity

    bat
    bibata-cursors
    blender
    bottom
    buf

    cabal-install
    clipse

    deno
    difftastic
    duckdb
    duf

    elixir_1_16
    elixir-ls
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
    gitbutler
    go-task
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-ugly

    haskell-language-server
    haskellPackages.hoogle
    haskellPackages.tidal

    imhex
    inkscape

    jq
    jujutsu
    just

    k9s
    kalker
    kicad
    krita

    lazygit
    lmms
    lua-language-server
    luajit
    lutris

    mindustry-wayland
    mpv

    nb
    nil
    numbat

    p7zip
    pandoc
    peazip
    playerctl
    # pureref

    skk-dicts
    spacedrive
    stack
    stylish-haskell
    stylua
    sunvox
    supercollider-with-sc3-plugins

    thunderbird
    treefmt
    typst

    unzip
    ueberzugpp

    osu-lazer-bin
    oxker

    ripgrep
    ripgrep-all
    reversal-icon-theme
    rustup

    hledger

    vlc
    vmware-workstation

    wireshark
    wl-clipboard
    wolfram-engine

    grim # for screenshot in wayland
    slurp

    xclip

    yazi

    zola
    zoom-us
    zoxide
    zrythm

    libsForQt5.xp-pen-deco-01-v2-driver
  ] ++ [
    superdirt-install
  ];
}
