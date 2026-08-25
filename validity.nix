{ config, pkgs, localPackages, modules, lib, ... }:

{
imports = [
#    (args: import ../python-validity (args // {localPackages = localPackages;}))
    #../open-fprintd
  ];
    environment.systemPackages = [
      localPackages.python-validity
      pkgs.fprintd
    ];

	services.fprintd.enable = false;

	finit.services.open-fprintd = {
		    description = "open-fprintd service";
		    runlevels = "2345";
		    conditions = "service/syslogd/ready";
		    command = "${pkgs.open-fprintd}/bin/open-fprintd";
		  };
    
	finit.services.python-validity = {
	    description = "python-validity service";
	    runlevels = "2345";
	    conditions = "service/open-fprintd/ready";
	    command = "${localPackages.python-validity}/bin/python-validity";
	  };
    #systemd.packages = [ localPackages.python-validity ];
    #systemd.services.python3-validity.wantedBy = [ "multi-user.target" ];

    # need to register the dbus configuration files of the package, otherwise we will get access errors
    services.dbus.packages = [ 
    localPackages.python-validity 
    pkgs.open-fprintd 
    ];
}
