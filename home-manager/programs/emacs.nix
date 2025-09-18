{ pkgs, config, ... }:
let
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

      corfu
      cape
      kind-icon
      corfu-prescient

      ddskk

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

      envrc

      doom-modeline
      ghub
      nerd-icons

      dashboard

      vterm
      vterm-toggle

      rainbow-delimiters
      highlight-indent-guides
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

  emacsPkg = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages extraPackages';
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
      vterm_printf() {
          if [ -n "$TMUX" ] \
              && { [ "$\{TERM%%-*}" = "tmux" ] \
                  || [ "$\{TERM%%-*}" = "screen" ]; }; then
              # Tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$1"
          elif [ "$\{TERM%%-*}" = "screen" ]; then
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$1"
          else
              printf "\e]%s\e\\" "$1"
          fi
      }

      vterm_prompt_end() {
          vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
      }
      setopt PROMPT_SUBST
      PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
    '';
    shellAliases = {
      emacs = "emacsclient -c -a \"\"";
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
