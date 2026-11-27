# voxtype-osd-gtk4 — Voxtype の GTK4 版オンスクリーン表示 (OSD)。
#
# nixpkgs の voxtype パッケージは OSD のフロントエンドを同梱していないため、
# 公式リリースのバイナリを取ってきて NixOS 用にパッチする。
# バージョンは nixpkgs の voxtype に合わせる (ずれるとハッシュで落ちる)。
{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  wrapGAppsHook4,
  gtk4,
  gtk4-layer-shell,
  voxtype,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "voxtype-osd-gtk4";
  version = voxtype.version;

  src = fetchurl {
    url = "https://github.com/peteonrails/voxtype/releases/download/v${finalAttrs.version}/voxtype-${finalAttrs.version}-linux-x86_64-osd-gtk4";
    hash = "sha256-4W+W3PBGuc+olVQbrLcwU3CPPt76jSRaK0I7KIzVoPA=";
  };

  dontUnpack = true;

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    gtk4-layer-shell
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/voxtype-osd-gtk4
    runHook postInstall
  '';

  dontStrip = true;

  meta = {
    description = "GTK4 on-screen display frontend for Voxtype";
    homepage = "https://voxtype.io";
    license = lib.licenses.mit;
    mainProgram = "voxtype-osd-gtk4";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
