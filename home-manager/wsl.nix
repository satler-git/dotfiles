{
  pkgs,
  lib,
  inputs,
  ...
}:
let
  dicts_lua = ''
    -- SKKELETON's JISYO
    vim.fn['skkeleton#config']({
      globalDictionaries = { '~/.skk/SKK-JISYO.L', '~/.skk/SKK-JISYO.pinyin' },
      eggLikeNewline = true,
    })
  '';
in
{
  programs.home-manager.enable = true;

  home.stateVersion = "24.05"; # Don't change this

  home.packages =
    with pkgs;
    [
      # basic CLI
      bat
      bottom
      curl
      delta
      direnv
      eza
      fd
      fzf
      gh
      ghq
      git
      gnumake
      htop
      jq
      nix-output-monitor
      nix-your-shell
      ripgrep
      tmux
      tree
      unzip
      wget
      zip
      zoxide
    ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    ignores = [
      ".env"
      "*.swp"
      ".direnv/*"
      "memo.md"
    ];
    settings = {
      user = {
        email = "satler@satler.dev";
        name = "satler";
      };
      core.editor = "nvim";
      push.autoSetupRemote = true;
      init.defaultBranch = "main";
      commit.verbose = true;
      ghq.root = "~/repos";
      alias = {
        s = "status";
        d = "diff";
      };
      github.user = "satler-git";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.fzf.enable = true;
  programs.dircolors.enable = true;

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 100000;
      save = 1000000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      extended = true;
    };
    shellAliases = {
      v = "nvim";
      n = "nvim";
      l = "eza -F";
      ll = "eza -F -l";
      la = "eza -F -a";
      lla = "eza -F -l -a";
      dev = "nix develop";
    };
    initContent = ''
      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi
    '';
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    viAlias = true;
    withRuby = true;
    withPython3 = true;
    extraPackages =
      with pkgs;
      [
        gcc # for Tree-sitter
        nodejs
        deno
        sqlite
        sqlite.dev

        # Lang-servers
        efm-langserver
        typos-lsp
        lua-language-server
        nil
        taplo # Toml
        vscode-langservers-extracted
        yaml-language-server
        biome
        typescript-language-server
        vtsls
        ruff
        tinymist # For typst

        # Formatter
        biome
        nixfmt
        rustfmt
        stylua
        typstyle
      ];
    extraLuaPackages = ps: [
      ps.jsregexp
    ];
  };

  xdg.configFile = {
    "nvim/" = {
      target = "nvim";
      source = ../config/nvim;
      recursive = true;
    };
    "nvim/lua/dicts.lua" = {
      text = dicts_lua;
    };
    "nvim/lua/extra.lua" = {
      text = ''
        vim.g.sqlite_clib_path = '${pkgs.sqlite.out}/lib/libsqlite3.so'
      '';
    };
    "efm-langserver/config.yaml" = {
      text = pkgs.lib.generators.toYAML { } (
        import ./programs/neovim/efm-config.nix {
          inherit pkgs;
          lib = pkgs.lib;
        }
      );
    };
  };

  home.file = {
    ".skk/SKK-JISYO.L".source = "${pkgs.skkDictionaries.l}/share/skk/SKK-JISYO.L";
    ".skk/SKK-JISYO.pinyin".source = "${pkgs.skkDictionaries.pinyin}/share/skk/SKK-JISYO.pinyin";
  };
}
