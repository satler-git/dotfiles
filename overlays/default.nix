{ inputs }:
{
  stable = final: prev: {
    inherit (inputs.nixpkgs-stable.legacyPackages.${final.stdenv.hostPlatform.system})
      # fcitx5-mozc
      # mozc
      ;
  };

  temporary-fix = final: prev: {
    inherit (inputs.nixpkgs-unstable-small.legacyPackages.${final.stdenv.hostPlatform.system})
      # https://nixpk.gs/pr-tracker.html?pr=356590
      fcitx5-mozc
      ;
  };
}
