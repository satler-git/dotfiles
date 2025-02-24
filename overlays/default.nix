{ inputs }:
{
  stable = final: _: {
    inherit (inputs.nixpkgs-stable.legacyPackages.${final.stdenv.hostPlatform.system})
      blender
      epson-escpr
      epson-escpr2
      gutenprint
      kicad

      open-webui
      reversal-icon-theme
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

  mold = final: prev: {
    neovim = prev.neovim.override (old: {
      stdenv = final.useMoldLinker final.clangStdenv;
    });
    yazi-unwrapped = prev.yazi-unwrapped.override (old: {
      stdenv = final.useMoldLinker final.clangStdenv;
    });
  };
}
