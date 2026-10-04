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
  boot.kernelPackages = pkgs.linuxPackages_latest; 
  #pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
  boot.kernelModules = [ "ntsync" ];
  programs.modprobe.blacklist = [ "iTCO_wdt" "intel_oc_wdt" ];
  boot.kernelParams = ["nowatchdog" /*"mitigations=off"*/ /*"i915.enable_psr=0" "i915.enable_fbc=0"*/];
  boot.loader.efi.canTouchEfiVariables = true;
}
