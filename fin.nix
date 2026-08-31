{ config, pkgs, inputs, localPackages,  modules, lib, ... }:

{
# graphical runlevel
  finit.runlevel = 3;

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
   /* finit.services.libvirtd = {
          description = "libvirt virtualisation daemon";
          runlevels   = "2345";
          conditions  = [ "service/syslogd/ready" ];
          command     = "${pkgs.libvirt}/bin/libvirtd";
        };*/
}
