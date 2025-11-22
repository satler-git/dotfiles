{ inputs }:
{
  stable = final: _: {
    inherit
      (import inputs.nixpkgs-stable {
        config = {
          allowUnfree = true;
        };
        system = final.stdenv.hostPlatform.system;
      })
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

      # deno # 2.3.5 crashes, denops

      waybar

      gimp

      prismlauncher

      anki
      ;
  };

  latest = final: prev: {
    inherit
      (import inputs.nixpkgs-unstable-small {
        config = {
          allowUnfree = true;
        };
        system = final.stdenv.hostPlatform.system;
      })
      antigravity
      ;
  };

  mold = final: prev: {
    neovim = prev.neovim.override ({
      stdenv = final.useMoldLinker final.clangStdenv;
    });
  };
}
