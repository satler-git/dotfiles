{ inputs }:
{
  stable = final: prev: {
    inherit (inputs.nixpkgs-stable.legacyPackages.${final.stdenv.hostPlatform.system})
      gutenprint
      epson-escpr
      epson-escpr2
      blender
      kicad
      ;
  };

  # temporary-fix = final: prev: {
  #   inherit (inputs.nixpkgs-unstable-small.legacyPackages.${final.stdenv.hostPlatform.system})
  #     ;
  # };
}
