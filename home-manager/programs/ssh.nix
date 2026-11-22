{
  # 1Password の SSH エージェントを使う。
  # 1Password 側の設定で「SSH エージェントを使用」を有効にしておくこと。
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."*" = {
      IdentityAgent = "~/.1password/agent.sock";
    };
  };
}
