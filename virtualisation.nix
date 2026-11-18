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
