{ inputs }:
{
  stable = final: prev: {
    inherit (inputs.nixpkgs-stable.legacyPackages.${final.stdenv.hostPlatform.system})
      # fcitx5-mozc
      ;
  };

  temporary-fix = final: prev: {
    inherit (inputs.nixpkgs-unstable-small.legacyPackages.${final.stdenv.hostPlatform.system})
      # fcitx5-mozc
      ;
  };
}
