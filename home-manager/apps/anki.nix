{
  pkgs,
  osConfig,
  lib,
  ...
}:
let
  appName = "anki";
  ime = osConfig.i18n.inputMethod.type;

  wrappedAnki = pkgs.symlinkJoin {
    name = appName;
    paths = [ pkgs.${appName} ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = lib.strings.concatStrings [
      "wrapProgram $out/bin/"
      appName
      " --set GTK_IM_MODULE ${ime}"
    ];
  };
in
{
  home.packages = [
    wrappedAnki
  ];
}
