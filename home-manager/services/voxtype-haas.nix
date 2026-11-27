# Voxtype + Haas-ja-v1.0 (Q8_0) + speech.cpp
#
# 構成:
#   niri のキーバインド -> `voxtype record toggle`
#     -> voxtype daemon (録音)
#     -> HTTP POST http://127.0.0.1:18080/v1/audio/transcriptions
#        (OpenAI 互換。Voxtype の [whisper] mode = "remote")
#     -> speech.cpp の `speech serve` が Haas-ja-v1.0 で認識
#     -> wtype でカーソル位置に日本語を入力
#
# モデルは Nix ストアではなく speech.cpp のキャッシュ
# (~/.cache/speech.cpp) に置く。取得は oneshot の systemd ユニットで行い、
# speech-cpp.service -> voxtype.service の順に依存させる。
#
# 検証済みの組み合わせ (2026-11-27, tau):
#   voxtype 1.1.1 (nixpkgs) / speech.cpp 0.11.2 (CPU リリース) /
#   Haas-616M-ja-v1.0-Q8_0 / Q6_K
#
# 配置先: home-manager/services/voxtype-haas.nix
#         (speech-cpp.nix は home-manager/pkgs/speech-cpp.nix)
# 併せて services/default.nix に ./voxtype-haas.nix を追加する。
{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.services.voxtypeHaas;

  speech = pkgs.callPackage ../pkgs/speech-cpp.nix { };

  # 公式リリースの GTK4 OSD。nixpkgs の voxtype はフロントエンドを同梱しない。
  osd = pkgs.callPackage ../pkgs/voxtype-osd-gtk4.nix { };

  threadsArg = lib.optionalString (cfg.threads != null) " --threads ${toString cfg.threads}";
in
{
  options.services.voxtypeHaas = {
    enable = lib.mkEnableOption "Voxtype dictation backed by speech.cpp and Haas-ja-v1.0";

    model = lib.mkOption {
      type = lib.types.str;
      default = "haas-ja-v1.0:q6_k";
      description = ''
        speech.cpp のカタログ名。既定は Q6_K (0.51 GB)。
        Q8_0 は "haas-ja-v1.0"、Q4_K は "haas-ja-v1.0:q4_k"。
        tau での実測 (4.24 s 音声): Q8_0 0.96 s / Q6_K 0.56 s / Q4_K 0.54 s。
      '';
    };

    port = lib.mkOption {
      type = lib.types.port;
      default = 18080;
      description = "speech.cpp server port. Bound to 127.0.0.1 only.";
    };

    device = lib.mkOption {
      type = lib.types.enum [
        "cpu"
        "gpu"
        "auto"
      ];
      default = "cpu";
      description = "Device speech.cpp runs Haas-ja on.";
    };

    threads = lib.mkOption {
      type = lib.types.nullOr lib.types.ints.positive;
      default = 8;
      description = ''
        CPU threads for speech.cpp. tau は 8 コアなので 8。
        16 にすると SMT 競合で 4 倍以上遅くなるので上げないこと。
      '';
    };

    osdPosition = lib.mkOption {
      type = lib.types.enum [
        "bottom-center"
        "top-center"
        "bottom-left"
        "bottom-right"
        "top-left"
        "top-right"
      ];
      default = "bottom-center";
      description = "録音中に出す波形 OSD の位置。";
    };

    osdFrontend = lib.mkOption {
      type = lib.types.enum [
        "gtk4"
        "native"
        "quickshell"
      ];
      default = "quickshell";
      description = ''
        OSD の実装。
        - gtk4: 素朴な帯。起動は軽い。
        - native: wgpu/egui。公式のビルド済みバイナリが無い。
        - quickshell: レイアウト・発光・枠をカスタムできる。見た目は一番良い。
      '';
    };

    osdLayout = lib.mkOption {
      type = lib.types.enum [
        "compact"
        "wide"
        "minimal"
        "tile"
        "orb"
      ];
      default = "minimal";
      description = ''
        Quickshell OSD のレイアウト。minimal は細い帯 (260x48)、
        orb は円形 (168px)、tile は正方形。
      '';
    };

    osdTopMargin = lib.mkOption {
      type = lib.types.float;
      default = 0.84;
      description = ''
        中央寄せのときの画面上端からの位置 (0..1)。小さいほど上。
        入力欄に被るなら 0.05 前後、下に置くなら 0.85。
      '';
    };

    osdOpacity = lib.mkOption {
      type = lib.types.float;
      default = 0.9;
      description = "OSD パネルの不透明度。";
    };

    osdWidth = lib.mkOption {
      type = lib.types.ints.positive;
      default = 400;
      description = ''
        パネル幅 (px)。minimal レイアウトでは 260 が上限なので、
        さらに小さくしたいときは 200 などにする。
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.voxtype # wtype / wl-clipboard / dotool はラッパーが同梱
      speech
      osd
    ];

    # Quickshell OSD の QML 一式。voxtype のソースに同梱されている。
    xdg.dataFile = lib.mkIf (cfg.osdFrontend == "quickshell") {
      "voxtype/quickshell".source = "${pkgs.voxtype.src}/quickshell";
    };

    xdg.configFile."voxtype/config.toml".text = ''
      engine = "whisper"
      state_file = "auto"

      [hotkey]
      enabled = false

      [whisper]
      mode = "remote"
      remote_endpoint = "http://127.0.0.1:${toString cfg.port}"
      remote_model = "Haas-ja-v1.0"
      language = "ja"
      remote_timeout_secs = 60

      [output]
      mode = "type"
      fallback_to_clipboard = true
      type_delay_ms = 0

      # 録音中に出るフローティングの波形パネル。
      # Wayland には「入力欄の位置」を取る手段が無いので、画面下中央に固定。
      [osd]
      enabled = true
      frontend = "${cfg.osdFrontend}"
      position = "${cfg.osdPosition}"
      width_px = ${toString cfg.osdWidth}
      ${lib.optionalString (cfg.osdFrontend == "quickshell") ''
        layout = "${cfg.osdLayout}"
        palette = "fallback"
        top_margin = ${toString cfg.osdTopMargin}
        opacity = ${toString cfg.osdOpacity}

        [osd.frame]
        background = "none"
        border = "none"
        glow = true
        halo = false
      ''}

      # 通知はうるさいので切ったまま。
      [output.notification]
      on_recording_start = false
      on_recording_stop = false
      on_transcription = false
    '';

    # モデル取得は 1 回だけ。2 回目以降は SHA-256 の確認だけで即終わる。
    # 途中で切れても `speech pull` は続きから再開する。
    systemd.user.services.speech-cpp-model = {
      Unit = {
        Description = "Fetch the ${cfg.model} GGUF for speech.cpp";
        Documentation = [ "https://github.com/nyosegawa/speech.cpp" ];
      };
      Service = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${speech}/bin/speech pull ${cfg.model}";
        Environment = [ "SPEECH_NO_UPDATE_CHECK=1" ];
        TimeoutStartSec = "30min";
      };
      Install.WantedBy = [ "default.target" ];
    };

    # 表示系に依存しないので default.target で良い。
    systemd.user.services.speech-cpp = {
      Unit = {
        Description = "speech.cpp ASR server (${cfg.model})";
        Documentation = [ "https://github.com/nyosegawa/speech.cpp" ];
        Requires = [ "speech-cpp-model.service" ];
        After = [ "speech-cpp-model.service" ];
      };
      Service = {
        ExecStart = "${speech}/bin/speech serve ${cfg.model} --host 127.0.0.1 --port ${toString cfg.port} --device ${cfg.device}${threadsArg}";
        Environment = [ "SPEECH_NO_UPDATE_CHECK=1" ];
        Restart = "on-failure";
        RestartSec = 3;
      };
      Install.WantedBy = [ "default.target" ];
    };

    # WAYLAND_DISPLAY が要るので graphical-session.target にぶら下げる
    # (niri.service が BindsTo=graphical-session.target なので、niri 起動後に
    #  この target が reached になる)。
    systemd.user.services.voxtype = {
      Unit = {
        Description = "Voxtype push-to-talk voice-to-text daemon";
        PartOf = [ "graphical-session.target" ];
        After = [
          "graphical-session.target"
          "pipewire.service"
          "pipewire-pulse.service"
          "speech-cpp.service"
        ];
        Wants = [ "speech-cpp.service" ];
      };
      Service = {
        Type = "simple";
        ExecStart = "${pkgs.voxtype}/bin/voxtype daemon";
        Restart = "on-failure";
        RestartSec = 5;
      };
      Install.WantedBy = [ "graphical-session.target" ];
    };
  };
}
