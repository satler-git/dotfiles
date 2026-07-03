{ inputs }:
{
  stable =
    final: _:
    let
      stablePkgs = import inputs.nixpkgs-stable {
        config = {
          allowUnfree = true;
        };
        system = final.stdenv.hostPlatform.system;
      };
    in
    {
      inherit (stablePkgs)
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
        ;

      # Pin neovim to stable. Provide the *unwrapped* build as `neovim`
      # (mirroring neovim-nightly-overlay's convention) so that home-manager's
      # wrapNeovimUnstable — which expects an unwrapped neovim with a `.lua`
      # passthru — wraps the stable neovim-unwrapped instead of the nightly one.
      neovim = stablePkgs.neovim-unwrapped;
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
      anki
      ;
  };

  # mold = final: prev: {
  #   neovim = prev.neovim.override ({
  #     stdenv = final.useMoldLinker final.clangStdenv;
  #   });
  # };
}
