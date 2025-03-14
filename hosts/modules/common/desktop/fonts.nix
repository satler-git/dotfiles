{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      ibm-plex
      jetbrains-mono
      material-design-icons
      migmix
      monaspace

      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji

      source-han-sans-vf-ttf

      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      nerd-fonts.monaspace
    ];
    fontDir.enable = true;
    fontconfig = {
      defaultFonts = {
        serif = [
          "IBM Plex Sans JP"
          "Noto Serif CJK JP"
          "Noto Color Emoji"
        ];
        sansSerif = [
          "IBM Plex Sans JP"
          "Noto Sans CJK JP"
          "Noto Color Emoji"
        ];
        monospace = [
          "Monaspace Argon"
          "JetBrainsMono Nerd Font"
          "Noto Color Emoji"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
