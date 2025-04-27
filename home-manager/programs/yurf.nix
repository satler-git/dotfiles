{ inputs, ... }:
{
  imports = [
    inputs.yurf.homeManagerModules.yurf
  ];

  programs.yurf = {
    enable = true;

    task = [
      {
        name = "light: Increase by 10";
        command = "light -A 10";
      }
      {
        name = "light: Decrease by 10";
        command = "light -U 10";
      }
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
