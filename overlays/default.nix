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

      biome

      kalker

      pympress
      ;
  };

  # temporary-fix = final: prev: {
  #   inherit (inputs.nixpkgs-unstable-small.legacyPackages.${final.stdenv.hostPlatform.system})
  #     ;
  # };

  mold = final: prev: {
    neovim = prev.neovim.override ({
      stdenv = final.useMoldLinker final.clangStdenv;
    });
    yazi-unwrapped = prev.yazi-unwrapped.override ({
      stdenv = final.useMoldLinker final.clangStdenv;
    });
  };
}
