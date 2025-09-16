{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;

    extraPackages =
      epkgs:
      (with epkgs; [
        leaf
        leaf-keywords
        leaf-convert
        leaf-tree

        # doom-themes

        macrostep

        vertico
        prescient
        vertico-prescient
        marginalia
        orderless

        embark
        embark-consult # TODO: eglot?
        consult # TODO: yasuni ghq? projectile?
        consult-dir
        affe

        reformatter

        treesit-grammars.with-all-grammars

        rainbow-mode

        nix-mode
        nix-ts-mode
        hledger-mode

        undo-tree

        evil
        evil-surround

        editorconfig

        git-gutter

        dmacro

        wakatime-mode
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
        nixfmt-rfc-style
        rustfmt
        stylish-haskell # TODO:
        stylua
        typstyle # TODO:
        yamlfmt

        # DAP
        haskellPackages.ghci-dap
        haskellPackages.haskell-debug-adapter
      ]);
  };

  # TODO: deamon/emacsclient
  # services.emacs = { };

  home.file = {
    ".emacs.d/init.el".source = ../../config/emacs/init.el;
    ".emacs.d/themes/aura-soft-dark-soft-text-theme.el".source = ../../config/emacs/aura-theme.el; # TODO:
    ".emacs.d/early-init.el".source = ../../config/emacs/early-init.el;
  };
}
