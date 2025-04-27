{ inputs, ... }:
{
  imports = [
    inputs.yurf.homeManagerModules.yurf
  ];

  programs.yurf = {
    enable = true;

    task = [
      {
        name = "hyprsunset: reset";
        command = "hyprctl hyprsunset identity";
      }
      {
        name = "hyprsunset: sunset";
        command = "hyprctl hyprsunset temperature 2500";
      }
    ];
  };
}
