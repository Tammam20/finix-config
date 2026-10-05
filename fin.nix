{
  config,
  pkgs,
  inputs,
  localPackages,
  modules,
  lib,
  ...
}:

{
  # graphical runlevel
  finit.runlevel = 3;

  finit.rlimits = {
    hard.as = 8388608; # no more than 8MB of address space
    soft.core = "unlimited"; # core dumps may be arbitrarily large
    cpu = 10; # soft & hard = 10 sec
  };

  finit.cgroups.system.settings = {
    "cpu.weight" = 100;
  };

  finit.services.open-fprintd = {
    description = "open-fprintd service";
    runlevels = "2345";
    conditions = "service/dbus/ready";
    command = "${pkgs.open-fprintd}/lib/open-fprintd/open-fprintd";
  };

  finit.services.python-validity = {
    description = "python-validity service";
    runlevels = "2345";
    conditions = "service/open-fprintd/ready";
    command = "${localPackages.python-validity}/bin/python-validity-dbus-service";
  };

  finit.services.nix-daemon = {
    environment.CURL_CA_BUNDLE = config.security.pki.caBundle;
  };

  # libvirt
  /*
    finit.services.libvirtd = {
        description = "libvirt virtualisation daemon";
        runlevels   = "2345";
        conditions  = [ "service/syslogd/ready" ];
        command     = "${pkgs.libvirt}/bin/libvirtd";
      };
  */
}
