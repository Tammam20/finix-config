{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{

  # Use stable kernel.
  boot.kernelPackages = pkgs.linuxPackages;
  #pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  boot.kernelModules = [ "ntsync" ];

  programs.modprobe.blacklist = [
    "iTCO_wdt"
    "intel_oc_wdt"
  ];

  boot.kernelParams = [
    "nowatchdog" # "mitigations=off" "i915.enable_psr=0" "i915.enable_fbc=0"
  ];

  boot.loader.efi.canTouchEfiVariables = true;

  services = {

    earlyoom = {
      enable = true;
      extraArgs = [
        "-r"
        "3600"
      ];
    };

    getty.enable = true;

    sysklogd.enable = true;

    fwupd.enable = true;

    fstrim = {
      enable = true;

      fstrim.interval = "daily";
    };

    chrony.enable = true;

    fcron.enable = true;

  };

  # graphical runlevel
  finit.runlevel = 3;

  /*
    	    finit.rlimits = {
    	      nofile = 524288; # soft & hard
    	    };
  */

  finit.cgroups.system = {
    "cpu.weight" = 100;
  };

}
