{ pkgs, lib, ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user.email = "mitsclatw24@mbr.nifty.com";
      user.name = "satler-git";
      ui = {
        paginate = "never";
        editor = "nvim";
        diff = {
          format = "git";
          tool = [ "${lib.getExe pkgs.delta}" "--true-color" "always" "--no-gitconfig" "--color-only" "$left" "$right"];
        };
        signing = {
          sign-all = true;
          backend = "gpg";
          key = "97A7F4C53C4121DD";
        };
      };
    };
  };
}
