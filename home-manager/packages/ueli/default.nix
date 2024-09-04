{ appimageTools, fetchurl }:
let
  pname = "ueli";
  version = "9.3.5";

  src = fetchurl {
    url = "https://github.com/oliverschwendener/ueli/releases/download/v${version}/${pname}-${version}.AppImage";
    hash = "sha256-he1uGC1M/nFcKpMM9JKY4oeexJcnzV0ZRxhTjtJz6xw=";
  };
in
appimageTools.wrapType2 {
  inherit pname version src;
}
