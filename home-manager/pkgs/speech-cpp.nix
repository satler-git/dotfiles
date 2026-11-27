# speech.cpp — official Linux x64 CPU release, repackaged for NixOS.
#
# Upstream ships a portable binary (glibc >= 2.34, AVX2/FMA/F16C); it links only
# libc/libm because libstdc++ is statically linked. autoPatchelfHook makes it
# independent of nix-ld, which is enabled on tau anyway.
#
# Verified: `speech --version` -> 0.11.2, and an ASR round trip with
# Haas-616M-ja-v1.0-Q8_0.gguf returns the expected Japanese text.
{
  lib,
  stdenv,
  fetchurl,
  unzip,
  autoPatchelfHook,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "speech-cpp";
  version = "0.11.2";

  src = fetchurl {
    url = "https://github.com/nyosegawa/speech.cpp/releases/download/v${finalAttrs.version}/speech-${finalAttrs.version}-linux-x64-cpu.zip";
    hash = "sha256-4E3kOA2KDxvdYbHGG3B1Njp8rceNMdQPZBh3ULDDmn0=";
  };

  nativeBuildInputs = [
    unzip
    autoPatchelfHook
  ];
  buildInputs = [ stdenv.cc.cc.lib ];

  unpackPhase = "unzip -q $src";

  installPhase = ''
    runHook preInstall
    install -Dm755 speech $out/bin/speech
    install -Dm644 speech.h $out/include/speech.h
    install -Dm755 libspeech.so.4 $out/lib/libspeech.so.4
    ln -sf libspeech.so.4 $out/lib/libspeech.so
    runHook postInstall
  '';

  dontStrip = true;

  meta = {
    description = "Speech synthesis, recognition and voice activity detection on ggml";
    homepage = "https://github.com/nyosegawa/speech.cpp";
    license = lib.licenses.mit;
    mainProgram = "speech";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
})
