{ config, pkgs, lib, ... }:

let
  composefs = pkgs.callPackage ./composefs {};
in
{
  boot.kernelPackages = pkgs.linuxPackages_6_1.extend (self: super: {
    composefs = self.callPackage ./composefs/kernelmodule.nix {};
  });

  boot.kernelPatches = [
    { name = "enable-fsverity";
      patch = ./export-fsverity-get-digest.patch;
      extraStructuredConfig = with lib.kernel; {
        FS_VERITY = yes;
      };
    }
  ];

  boot.extraModulePackages = [ config.boot.kernelPackages.composefs ];
  boot.initrd.kernelModules = [ "composefs" ];

  environment.systemPackages = [ composefs pkgs.fsverity-utils ];

  # Ensure the autoformat of the VM's default ext4 rootfs enable verity mode
  #virtualisation.fileSystems."/".formatOptions = "-O verity";

  users.users.root.initialPassword = "changeme";
}
