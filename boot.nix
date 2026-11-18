{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{

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
