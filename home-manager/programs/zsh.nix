{ pkgs, ... }:
{
  # home.file = {
  #   ".zshrc".source = ../../config/zsh/zshrc;
  # };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
        # Completion
        autoload -Uz compinit; compinit
        autoload -Uz colors; colors

        zstyle ':completion:*:default' menu select=2
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
      '';
    initExtra = ''
        setopt auto_param_slash
        setopt auto_param_keys

        setopt correct
        setopt interactive_comments

        setopt no_beep
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
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "sha256-zhaXjrNL0amxexbZm4Kr5Y/feq1+2zW0O6eo9iZhmi0=";
        };
      }
      {
        name = "Feature-rich-Syntax-Highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "z-shell";
          repo = "F-Sy-H";
          rev = "v1.67";
          sha256 = "sha256-zhaXjrNL0amxexbZm4Kr5Y/feq1+2zW0O6eo9iZhmi0=";
        };
      }
    ];
    history = {
      size = 100000;
      save = 1000000;
      path = "$HOME/.zsh_history";
      ignoreAllDups = true;
      extended = true;
    };
    zsh-abbr = {
      enable = true;
      abbreviations = {
        l = "eza -F";
        ll = "eza -F -l";
        la = "eza -F -a";
        lla = "eza -F -l -a";
        rr = "rm -rf";
        v = "nvim";
      };
    };
  };
  programs.dircolors = {
    enable = true;
    enableZshIntegration = true;
  };
}
