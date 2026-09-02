{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
  boot.loader.efi.canTouchEfiVariables = true;
}
