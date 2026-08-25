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

	security.pam.services = lib.mkMerge [
		{
			sudo.text = ''
			        # Account management.
			        account required pam_unix.so # unix (order 10900)
			
			        # Authentication management.
			        auth sufficient ${config.services.fprintd.package}/lib/security/pam_fprintd.so debug # fprintd (order 11400)
			        auth sufficient pam_unix.so likeauth try_first_pass # unix (order 11500)
			        auth required pam_deny.so # deny (order 12300)
			
			        # Password management.
			        password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
			
			        # Session management.
			        session required pam_env.so conffile=/etc/security/pam_env.conf readenv=0 # env (order 10100)
			        session required pam_unix.so # unix (order 10200)
			        session required pam_limits.so conf=/etc/security/limits.conf debug # limits (order 10400) - needed for rtprio/realtime
			      '';
			# xdg_runtime_dir not set when doing this with login bruh wth
			polkit-1.text = ''
			        # Account management.
			        account required pam_unix.so # unix (order 10900)
			
			        # Authentication management.
			        auth sufficient ${config.services.fprintd.package}/lib/security/pam_fprintd.so debug # fprintd (order 11400)
			        auth sufficient pam_unix.so likeauth try_first_pass # unix (order 11500)
			        auth required pam_deny.so # deny (order 12300)
			
			        # Password management.
			        password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
			
			        # Session management.
			        session required pam_env.so conffile=/etc/security/pam_env.conf readenv=0 # env (order 10100)
			        session required pam_unix.so # unix (order 10200)
			        session required pam_limits.so conf=/etc/security/limits.conf debug # limits (order 10400) - needed for rtprio/realtim
			      '';

		login.text = ''
					        # Account management.
					        account required pam_unix.so # unix (order 10900)
					        
					        # Authentication management.
					        auth sufficient ${config.services.fprintd.package}/lib/security/pam_fprintd.so debug # fprintd (order 11400)
					        auth optional pam_unix.so likeauth nullok # unix-early (order 11500)
					        auth sufficient pam_unix.so likeauth nullok try_first_pass # unix (order 12800)
					        auth required pam_deny.so # deny (order 13600)
					        
					        # Password management.
					        password sufficient pam_unix.so nullok yescrypt # unix (order 10200)
					        
					        # Session management.
					        session required pam_env.so conffile=/etc/security/pam_env.conf readenv=0 # env (order 10100)
					        session required pam_unix.so # unix (order 10200)
					        session required pam_loginuid.so # loginuid (order 10300)
					        session required pam_limits.so conf=/etc/security/limits.conf
					        session required ${pkgs.linux-pam}/lib/security/pam_lastlog.so silent # lastlog (order 10700)       
					        session optional ${pkgs.pam_rundir}/lib/security/pam_rundir.so
					}
	];
	
	 services.polkit.extraConfig = lib.optionalString (config.services.seatd.group != [ ]) ''
	       polkit.addRule(function(action, subject) {
	         if (action.id.startsWith("net.reactivated.fprint.device.")) {
	           var groups = ${builtins.toJSON config.services.seatd.group};
	 
	           if (groups.some(function(group) {
	             return subject.isInGroup(group);
	           })) {
	             return polkit.Result.YES;
	           }
	         }
	 
	         return polkit.Result.NOT_HANDLED;
	       });
	     '';
    
	providers.resumeAndSuspend.hooks = { 
	python-validity.enable = true;
	python-validity.action = "initctl restart python-validity";
	python-validity.event = "resume";
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

    # need to register the dbus configuration files of the package, otherwise we will get access errors
    services.dbus.packages = [ 
    localPackages.python-validity 
    pkgs.open-fprintd 
    ];
}
