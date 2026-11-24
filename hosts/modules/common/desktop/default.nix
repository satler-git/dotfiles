{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ../common.nix
    ./fonts.nix
  ];

  security.soteria.enable = lib.mkDefault true;

  programs.firefox.nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];

  # 1Password ブラウザ拡張のネイティブメッセージングホスト。
  # GUI 側も接続元の effective GID が onepassword グループかどうかを SO_PEERCRED で
  # 検証するため、1Password-BrowserSupport は setgid ラッパー経由で起動させる。
  # (アプリが生成する NMH マニフェストは既に /run/wrappers/bin/1Password-BrowserSupport を指す)
  users.groups.onepassword.gid = config.ids.gids.onepassword;
  security.wrappers."1Password-BrowserSupport" = {
    source = "${pkgs._1password-gui}/share/1password/1Password-BrowserSupport";
    owner = "root";
    group = "onepassword";
    setgid = true;
    setuid = false;
  };

  # home-manager の services.kbfs は PATH=/run/wrappers/bin から `fusermount` を
  # 直接 exec するが、nixpkgs 26.11 の programs.fuse は fuse3 の
  # fusermount3 ラッパーしか作らない。kbfsfuse (go-fuse) は fusermount3 を
  # 探さないため、KBFS が FUSE マウントに失敗して ~/keybase が空になる。
  # 互換のため fusermount 名でも同じ setuid ラッパーを提供する。
  # 背景: https://github.com/NixOS/nixpkgs/issues/526161 (fuse 2.x の削除)
  security.wrappers.fusermount = {
    source = "${lib.getBin pkgs.fuse3}/bin/fusermount3";
    owner = "root";
    group = "root";
    setuid = true;
  };

  # loginctl lock-session で hyprlock が起動するために必要
  # (PAM サービスが登録され、ロック解除時のパスワード認証が正しく動く)
  # ただし programs.hyprlock.enable は services.hypridle.enable も自動で有効にするので、
  # swayidle と競合しないよう明示的に無効化する
  programs.hyprlock.enable = lib.mkDefault true;
  services.hypridle.enable = lib.mkForce false;

  hardware.graphics = {
    enable = lib.mkDefault true;
  };

  boot.kernelPackages = lib.mkDefault pkgs.linuxKernel.packages.linux_zen;

  documentation = {
    man = {
      enable = true;
      man-db.enable = true;
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        # fcitx5-mozc
        fcitx5-gtk
        fcitx5-mozc-ut
        fcitx5-tokyonight
        fcitx5-skk
      ];
      waylandFrontend = true;

      settings.inputMethod = {
        GroupOrder = {
          "0" = "Default";
        };
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "jp";
          DefaultIM = "mozc";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-jp";
          Layout = "";
        };
        "Groups/0/Items/1" = {
          Name = "mozc";
          Layout = "";
        };
      };
    };
  };

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    # services.pipewire.jack.enable は LD_LIBRARY_PATH を汚すため非推奨。
    # JACK が必要なアプリは `pw-jack <command>` 経由で起動する。
  };

  security.rtkit.enable = true;

  environment = {
    systemPackages = with pkgs; [
      pipewire.jack
      # DMS (Quickshell) がトレイアイコンを解決するにはアイコンテーマが
      # XDG_DATA_DIRS に存在し、かつ gsettings でシステムテーマ名が取得できる必要がある。
      # - gsettings-desktop-schemas: org.gnome.desktop.interface schema を提供 (DMS が icon-theme を検出するのに必要)
      # - reversal-icon-theme: blueman-tray, application-exit, view-refresh などのアイコンを提供 (dark background 用)
      # - adwaita-icon-theme: Reversal-dark が Inherits する symbolic アイコン (input-keyboard-symbolic, bluetooth-symbolic 等) を提供
      gsettings-desktop-schemas
      reversal-icon-theme
      adwaita-icon-theme
    ];

    sessionVariables = {
      QT_IM_MODULE = "${config.i18n.inputMethod.type}";
    };

    pathsToLink = [ "/share/zsh" ];

    localBinInPath = true;
  };
}
