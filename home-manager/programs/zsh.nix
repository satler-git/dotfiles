{ pkgs, ... }:
{
  imports = [
    ./carapace.nix
  ];

  programs.zsh = {
    enable = true;
    # enableCompletion = true;
    completionInit = ''
      # Completion
      autoload -Uz compinit; compinit
      autoload -Uz colors; colors

      zstyle ':completion:*:default' menu select=2
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

      source <(jj util completion zsh)
    '';
    initExtra = ''
      setopt auto_param_slash
      setopt auto_param_keys

      setopt correct
      setopt interactive_comments

      setopt no_beep

      # Pure configs

      autoload -U promptinit; promptinit

      PURE_CMD_MAX_EXEC_TIME=10

      zstyle :prompt:pure:git:stash show yes
      zstyle ':prompt:pure:prompt:suspended_jobs' color magenta

      prompt pure

      function clear_screen() {
          clear
          zle reset-prompt
      }

      zle -N clear_screen
      bindkey '^L' clear_screen

      # nix-your-shell

      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi

      # https://zenn.dev/yuys13/articles/fish-plugins-2025
      __list_directory_contents () {
        if [[ -o interactive ]]; then
          if output=$(timeout 0.2s fd --max-depth 1 --exclude '.*' | wc -l); then
            if [ "$output" -le 20 ]; then
              eza
            fi
          fi
        fi
      }
      add-zsh-hook chpwd __list_directory_contents

      disable r
    '';
    plugins = [
      {
        name = "zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-completions";
          rev = "0.35.0";
          sha256 = "sha256-GFHlZjIHUWwyeVoCpszgn4AmLPSSE8UVNfRmisnhkpg=";
        };
      }
      {
        name = "pure";
        src = "${pkgs.pure-prompt}/share/zsh/site-functions";
      }
    ];
    autosuggestion = {
      enable = true;
    };
    syntaxHighlighting = {
      enable = true;
      # package = pkgs.zsh-f-sy-h;
    };
    history = {
      size = 100000;
      save = 1000000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      extended = true;
    };
    shellAliases = {
      rm = "echo \"This is not the command you are looking for.\"; false'";
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        l = "eza -F";
        ll = "eza -F -l";
        la = "eza -F -a";
        lla = "eza -F -l -a";
        # rrf = "rm -rf";
        v = "nvim";
        n = "nvim";
        lg = "lazygit";
        jd = "jj desc";
        put = "trash-put";
        sudow = "sudo env WAYLAND_DISPLAY=\"$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY\" XDG_RUNTIME_DIR=/user/run/0 QT_QPA_PLATFORM=wayland ";
      };
    };
  };
  programs.dircolors.enable = true;
  programs.eza.enable = true;
  programs.atuin = {
    enable = true;
    settings = {
      style = "full";
    };
  };

  programs.zoxide.enable = true;
}
