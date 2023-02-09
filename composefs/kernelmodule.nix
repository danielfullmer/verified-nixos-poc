{ stdenv, fetchFromGitHub, kernel }:

stdenv.mkDerivation {
  name = "composefs-module-${kernel.version}";

  src = fetchFromGitHub (import ./src.nix);

  #sourceRoot = "source/kernel";

  nativeBuildInputs = kernel.moduleBuildDependencies;

  hardeningDisable = [ "pic" "format" ];

  makeFlags = kernel.makeFlags ++ [
    "-C" "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(PWD)/kernel"
    #"KBUILD_MODPOST_WARN=1"
  ];
  installFlags = [
    "INSTALL_MOD_PATH=${placeholder "out"}"
  ];

  buildFlags = [ "modules" ];
  installTargets = [ "modules_install" ];
}
