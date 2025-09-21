{ pkgs, config, ... }:
let

  extraPackages =
    epkgs:
    let
      sources = (pkgs.callPackages ../../_sources/generated.nix { });

      typst-ts-mode = epkgs.trivialBuild {
        pname = "typst-ts-mode";
        version = "main";
        src = sources.typst-ts-mode.src;
        buildInputs = with epkgs; [ ];
      };

      typst-preview = epkgs.trivialBuild {
        pname = "typst-preview";
        version = "master";
        src = sources.typst-preview.src;
        buildInputs = with epkgs; [ websocket ];
      };
    in
    (with epkgs; [
      leaf
      leaf-keywords
      leaf-convert
      leaf-tree

      macrostep

      vertico
      prescient
      vertico-prescient
      marginalia
      orderless

      corfu
      cape
      kind-icon
      corfu-prescient

      ddskk

      embark
      embark-consult
      consult
      consult-dir
      affe

      reformatter

      treesit-grammars.with-all-grammars

      rainbow-mode

      nix-mode
      nix-ts-mode
      hledger-mode
      markdown-mode
      git-modes
      typst-ts-mode
      websocket
      typst-preview
      web-mode

      lsp-mode
      lsp-ui
      lsp-haskell
      lsp-treemacs
      consult-lsp

      flycheck
      consult-flycheck

      yasnippet
      yasnippet-snippets
      yasnippet-capf

      undo-tree

      evil
      evil-surround
      evil-matchit
      evil-collection

      editorconfig

      git-gutter

      dmacro

      wakatime-mode

      envrc

      moody
      minions
      nerd-icons

      dashboard

      vterm
      vterm-toggle

      rainbow-delimiters
      highlight-indent-guides

      hl-todo
      consult-todo

      ace-window

      dirvish

      projectile
      projectile-ripgrep
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
      stylish-haskell
      stylua
      typstyle
      yamlfmt

      # DAP
      haskellPackages.ghci-dap
      haskellPackages.haskell-debug-adapter

      nerd-fonts.symbols-only

      wakatime-cli
    ])
    ++ (config.programs.emacs.extraPackages epkgs);

  extraPackages' =
    epkgs:
    let
      packages = extraPackages epkgs;

      stylixConf = epkgs.trivialBuild {
        pname = "default";
        src = pkgs.writeText "default.el" config.programs.emacs.extraConfig; # stylix
        version = "0.1.0";
        packageRequires = packages;
      };
    in
    packages ++ [ stylixConf ];

  emacsPkg = (pkgs.emacsPackagesFor pkgs.emacs30-pgtk).emacsWithPackages extraPackages';
in
{
  programs.emacs = {
    enable = true;
    package = emacsPkg;
  };

  services.emacs = {
    enable = true;
    package = emacsPkg;
    client.enable = true;
  };

  programs.zsh = {
    initContent = ''
      if [[ "$INSIDE_EMACS" = 'vterm' ]] \
          && [[ -n ''${EMACS_VTERM_PATH} ]] \
          && [[ -f ''${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh ]]; then
      	source ''${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh
      fi
    '';
    shellAliases = {
      emacs = "emacsclient -c -a \"\"";
      nemacs = "emacsclient -cn -a \"\"";
    };
    zsh-abbr.abbreviations = {
      kem = "emacsclient -e '(kill-emacs)'";
      em = "emacs";
      nem = "nemacs";
    };
  };

  home.file = {
    ".emacs.d/init.el".source = ../../config/emacs/init.el;
    ".emacs.d/themes/aura-soft-dark-soft-text-theme.el".source = ../../config/emacs/aura-theme.el; # TODO:
    ".emacs.d/early-init.el".source = ../../config/emacs/early-init.el;
    ".emacs.d/etc/dashboard.txt".source = ../../config/emacs/dashboard;
    ".skk.el".text = ''
      (setq skk-large-jisyo "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L")
    '';
  };
}
