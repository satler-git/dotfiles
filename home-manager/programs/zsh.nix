{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
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

      if command -v nix-your-shell > /dev/null; then
        nix-your-shell zsh | source /dev/stdin
      fi
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
    zsh-abbr = {
      enable = true;
      abbreviations = {
        l = "eza -F";
        ll = "eza -F -l";
        la = "eza -F -a";
        lla = "eza -F -l -a";
        rrf = "rm -rf";
        v = "nvim";
        e = "nvim";
        lg = "lazygit";
      };
    };
  };
  programs.dircolors.enable = true;
  programs.eza.enable = true;
  programs.atuin.enable = true;
  programs.thefuck.enable = true;
  programs.starship.enable = true;
  programs.zoxide.enable = true;
}
