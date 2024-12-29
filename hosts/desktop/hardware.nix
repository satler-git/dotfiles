{
  config,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ../modules/hardware/nvidia.nix
    ../modules/hardware/microbit.nix
    ../modules/hardware/nvidia.nix
    ../modules/hardware/xp-pen-pentab.nix
    ../modules/hardware/printer.nix

    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
  ];
}
