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
        audacity

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

        gimp

        prismlauncher
        ;

      # Pin neovim to stable. Provide the *unwrapped* build as `neovim`
      # (mirroring neovim-nightly-overlay's convention) so that home-manager's
      # wrapNeovimUnstable — which expects an unwrapped neovim with a `.lua`
      # passthru — wraps the stable neovim-unwrapped instead of the nightly one.
      neovim = stablePkgs.neovim-unwrapped;
    };

  mozc-build = final: prev: {
    mozc = prev.mozc.overrideAttrs (old: {
      postPatch = (old.postPatch or "") + ''
        for ui in src/gui/dictionary_tool/dictionary_tool.ui \
                  gui/dictionary_tool/dictionary_tool.ui; do
          if [ -f "$ui" ]; then
            substituteInPlace "$ui" \
              --replace '::mozc::gui::DictionaryContentTableWidget' \
                        'mozc::gui::DictionaryContentTableWidget'
          fi
        done
      '';
    });
  };

  # 1Password 8.12.x の MFA ダイアログは、方式の一覧から「先頭」を無条件に初期選択し、
  # 選ばれた WebAuthn (セキュリティキー) ビューが失敗すると onCancel でダイアログごと
  # 閉じてしまう。TOTP を併用登録していても、セキュリティキーがあると TOTP を選ぶ前に
  # MFA が即座に消える (上流でも known issue として認識済み; Linux では ~40ms で失敗)。
  # ユーザーが方式を明示選択していない場合に TOTP/Code を優先させる暫定パッチ。
  # 上流で修正されたらこの overlay ごと削除する。
  # 参考: overlays/1password-mfa-totp.py (app.asar を再構築して integrity も再計算)
  onepassword-mfa-totp = final: prev: {
    _1password-gui = prev._1password-gui.overrideAttrs (old: {
      nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ final.python3 ];
      postInstall = (old.postInstall or "") + ''
        python3 ${./1password-mfa-totp.py} "$out/share/1password/resources/app.asar"
      '';
    });
  };

  pyrate-limiter = final: prev: {
    python3 = prev.python3.override {
      packageOverrides = pyfinal: pyprev: {
        "pyrate-limiter" = pyprev."pyrate-limiter".overridePythonAttrs (_: {
          doCheck = false;
        });
      };
    };
  };

  # mold = final: prev: {
  #   neovim = prev.neovim.override ({
  #     stdenv = final.useMoldLinker final.clangStdenv;
  #   });
  # };
}
