{
  pkgs,
  lib,
  ...
}:
{
  # ONLYOFFICE DesktopEditors は fontconfig を使わず /usr/share/fonts を
  # 直接読み、かつ symlink を処理できない upstream バグがあるため、
  # NixOS の fontDir 以下の symlink を認識できない。
  # 回避策としてフォントを実体として ~/.local/share/fonts にコピーする。
  # https://github.com/ONLYOFFICE/DocumentServer/issues/1859
  # https://github.com/NixOS/nixpkgs/issues/373521
  home.activation.copyFontsForOnlyOffice = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    fonts_dir="$HOME/.local/share/fonts"
    mkdir -p "$fonts_dir"

    copy_font_dir() {
      local src="$1"
      if [ -d "$src" ]; then
        cp -fL "$src"/* "$fonts_dir"/ 2>/dev/null || true
      fi
    }

    # Noto Sans CJK JP
    copy_font_dir "${pkgs.noto-fonts-cjk-sans}/share/fonts/opentype/noto-cjk"
    # IBM Plex Sans JP (otf + ttf)
    copy_font_dir "${pkgs.ibm-plex}/share/fonts/opentype"
    copy_font_dir "${pkgs.ibm-plex}/share/fonts/truetype"
    # Arial (corefonts, unfree)
    copy_font_dir "${pkgs.corefonts}/share/fonts/truetype"

    chmod 644 "$fonts_dir"/* 2>/dev/null || true
  '';
}
