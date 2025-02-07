{
  lib,
  pkgs,
  config,
  ...
}:
let
  userList = lib.attrNames config.users.users;
in
{
  environment.systemPackages =
    with pkgs;
    lib.mkBefore [
      virt-viewer
      virt-top
    ];

  virtualisation.libvirtd = {
    enable = lib.mkDefault true;
    qemu = {
      package = lib.mkDefault pkgs.qemu_kvm;

      ovmf = {
        enable = lib.mkDefault true;
        packages = [
          (pkgs.OVMF.override {
            secureBoot = true;
            tpmSupport = true;
          }).fd
        ];
      };
      swtpm.enable = lib.mkDefault true;
    };
  };

  virtualisation.spiceUSBRedirection.enable = lib.mkDefault true;

  programs.virt-manager = {
    enable = lib.mkDefault true;
  };

  users.groups.libvirtd.members = lib.mkDefault userList;
}
