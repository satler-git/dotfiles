{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;

    extraPackages =
      epkgs:
      (with epkgs; [
        leaf

        treesit-grammars.with-all-grammars

        nix-mode
        nix-ts-mode
      ])
      ++ (with pkgs; [
        # TODO: neovimと共通化
        typos-lsp

        buf
        elixir-ls
        ghc
        haskell-language-server
        luajit
        lua-language-server
        fenix.stable.rust-analyzer

        tinymist # For typst

        nil
        taplo # Toml
        vscode-langservers-extracted
        yaml-language-server

        astro-language-server
        biome
        typescript-language-server
        vtsls

        dart

        pest-ide-tools

        # Formatter
        biome
        nixfmt-rfc-style
        rustfmt
        stylish-haskell
        stylua
        typstyle

        # DAP
        haskellPackages.ghci-dap
        haskellPackages.haskell-debug-adapter
      ]);
  };

  # TODO: deamon/emacsclient
  # services.emacs = { };

  home.file = {
    ".emacs.d/init.el".source = ../../config/emacs/init.el;
    ".emacs.d/early-init.el".source = ../../config/emacs/early-init.el;
  };
}
