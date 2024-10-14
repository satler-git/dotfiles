let
  dunst = import ./dunst.nix;
  gpg-agent = import ./gpg-agent.nix;
in
{
  imports = [
    dunst
    gpg-agent
  ];
}
