# OpenPencil (https://github.com/open-pencil/open-pencil) は nixpkgs 未収録。
# 公式リリースは Linux 向けに AppImage を配布しており、中に GTK/WebKitGTK 一式を
# 同梱している。同梱バイナリは /lib64/ld-linux-x86-64.so.2 を interpreter に持つ
# ため NixOS 上ではそのままでは動かない。appimageTools.wrapType2 は buildFHSEnv
# 経由で AppImage を動かすので、同梱ライブラリをそのまま使える。
{
  lib,
  appimageTools,
  fetchurl,
}:

let
  pname = "open-pencil";
  version = "0.17.0";

  src = fetchurl {
    url = "https://github.com/open-pencil/open-pencil/releases/download/v${version}/OpenPencil_${version}_amd64.AppImage";
    hash = "sha256-Q9o9vXoiOhA2kt0tkZOob43cs9t1d703OUmq6EVelPw=";
  };

  contents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  # AppImage 側には含まれていないが、Tauri のトレイアイコンが実行時に
  # dlopen() するため FHS 環境に用意しておく。
  extraPkgs = pkgs: [ pkgs.libayatana-appindicator ];

  # home-manager の dconf が GIO_EXTRA_MODULES を nixpkgs の
  # libdconfsettings.so に向けるが、このアプリは AppImage 同梱の glib で動く
  # ため ABI が合わずモジュールのロードに失敗する。その結果 GSettings
  # (gtk-cursor-theme-name など) が既定値に落ち、Wayland のカーソルだけ
  # 既定テーマになる。AppImage 側の GIO_MODULE_DIR を使わせるため、
  # この変数だけ FHS 環境へ持ち込まない。
  extraBwrapArgs = [
    "--unsetenv"
    "GIO_EXTRA_MODULES"
  ];

  extraInstallCommands = ''
    install -Dm644 ${contents}/usr/share/applications/OpenPencil.desktop \
      $out/share/applications/OpenPencil.desktop

    # desktop ファイルの Exec は AppImage 内の名前 (OpenPencil) を指しているので、
    # FHS ラッパーのバイナリ名 ($out/bin/open-pencil) に差し替える。
    substituteInPlace $out/share/applications/OpenPencil.desktop \
      --replace-fail 'Exec=OpenPencil' 'Exec=${pname}'

    mkdir -p $out/share/icons
    cp -r ${contents}/usr/share/icons/hicolor $out/share/icons/
  '';

  meta = {
    description = "AI-native design editor, an open-source Figma alternative";
    homepage = "https://openpencil.dev";
    downloadPage = "https://github.com/open-pencil/open-pencil/releases";
    changelog = "https://github.com/open-pencil/open-pencil/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.mit;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    mainProgram = pname;
  };
}
