{ inputs }:
{
  stable = final: _: {
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

  goose-cli = final: prev: {
    goose-cli = prev.goose-cli.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.makeWrapper ];
      postInstall = ''
        wrapProgram $out/bin/goose \
          --prefix PATH : "${
            final.lib.makeBinPath [
              final.uv
              final.nodejs
            ]
          }"
      '';
    });
  };
}
