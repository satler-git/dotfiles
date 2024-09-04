{ appimageTools, fetchurl }:
let
  pname = "ueli";
  version = "9.3.5";

  src = fetchurl {
    url = "https://github.com/oliverschwendener/ueli/releases/download/v${version}/${pname}-${version}.AppImage";
    hash = "sha256-uLLuI+rDSMsd+TpnkRU228Ki9REvp4guV+Jgdzp5wI8=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}
