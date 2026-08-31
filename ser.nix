{ config, pkgs, inputs,  modules, lib, ... }:

{
  services = {
    polkit.enable = true;

    sysklogd.enable = true;

    dbus.enable = true;
    dbus.packages = [
        pkgs.dconf
        pkgs.xfconf
        pkgs.thunar
        pkgs.at-spi2-core
        #pkgs.tumbler
    ];

   	#mdevd.enable = true;
   	# required for graphical environments
    #mdevd.nlgroups = 4;
    gardendevd.enable = true;

    chrony.enable = true;
	getty.package = pkgs.util-linux // {
	  meta.mainProgram = "agetty";
	};
    dhcpcd.enable = true;
    thermald.enable = true;
    gvfs.enable = true;
    /*power-profiles-daemon.enable = true;
    power-profiles-daemon.extraGroups =  [
    config.services.seatd.group
    ];*/
    earlyoom.enable =  true;
    earlyoom.extraArgs = [
          "-r"
          "3600"
        ];
    bluetooth.enable = true;
    bluetooth.settings.Policy.AutoEnable = false;
    fstrim.enable = true;
    fstrim.interval = "daily";
    #upower.enable = true;
    #fwupd.enable = true;
	nftables.enable = true;
	rtkit.enable =  true;
	rtkit.extraGroups =  [
	      config.services.seatd.group
	 ];
    iwd.enable = true;
    seatd.enable = true;
    tlp.enable = true;
    tlp.settings = { 
            CPU_SCALING_GOVERNOR_ON_AC = "powersave";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
            #MEM_SLEEP_ON_AC = "deep";
            #MEM_SLEEP_ON_BAT = "deep";
            CPU_DRIVER_OPMODE_ON_AC = "active";
            CPU_DRIVER_OPMODE_ON_BAT = "active";
            CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_BOOST_ON_AC = 1;
            CPU_BOOST_ON_BAT = 0;
            RUNTIME_PM_ON_AC = "auto";
            RUNTIME_PM_ON_BAT = "auto";
            CPU_HWP_DYN_BOOST_ON_AC = 1;
            CPU_HWP_DYN_BOOST_ON_BAT = 0;
            #PCIE_ASPM_ON_AC = "powersave";
            #PCIE_ASPM_ON_BAT = "powersave";
    	      #WIFI_PWR_ON_AC = "off";
    	      #WIFI_PWR_ON_BAT = "off";
    
            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 30;
    
            INTEL_GPU_MIN_FREQ_ON_AC = 350;
            INTEL_GPU_MIN_FREQ_ON_BAT = 350;
            INTEL_GPU_MAX_FREQ_ON_AC = 1050;
            INTEL_GPU_MAX_FREQ_ON_BAT = 450;
            INTEL_GPU_BOOST_FREQ_ON_AC = 1100;
            INTEL_GPU_BOOST_FREQ_ON_BAT = 550;
            SOUND_POWER_SAVE_ON_AC = 1;
            SOUND_POWER_SAVE_ON_BAT = 1;
            START_CHARGE_THRESH_BAT1 = 75; 
            STOP_CHARGE_THRESH_BAT1 = 80;
            NMI_WATCHDOG = 0;
            #START_CHARGE_THRESH_BAT0 = 75; 
            #STOP_CHARGE_THRESH_BAT0 = 80; 
         };
    
    /*greetd = {
    enable = true;
    settings = {
   default_session = {
   command = "${pkgs.tuigreet}/bin/tuigreet";
}; 
};
};*/
 };

	services.nix-daemon = {
	  enable = true;
	  package = inputs.nix.packages.${pkgs.stdenv.system}.default;
	  settings = {
	    auto-optimise-store = true;
	    eval-cores = 0;
	    lazy-trees = true;
	    flake-registry = "https://channels.nixos.org/flake-registry.json";
	    experimental-features = [ "nix-command" "flakes" "parallel-eval" ];
	    trusted-users = [
	      "root"
	      "@wheel"
	    ];
	    substituters = [ 
	    	"https://finix.cachix.org"
		"https://attic.xuyh0120.win/lantian"
		"https://install.determinate.systems"
	     ];
	  trusted-public-keys = [ 
	  	"finix.cachix.org-1:0ejikHDeCp0UErsduUUHcg9IJczY2/h2e5132Z/As/c="
		"lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
		"cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
	   ];
	  };
	};

	# TODO: shouldn't this just be included by default?
	 /* services.mdevd.hotplugRules = lib.mkMerge [
	    (lib.mkAfter ''
	      SUBSYSTEM=input;.* root:input 660
	      SUBSYSTEM=sound;.* root:audio 660
	    '')
	
	    ''
	      grsec       root:root 660
	      kmem        root:root 640
	      mem         root:root 640
	      port        root:root 640
	      console     root:tty 600 @chmod 600 $MDEV
	      card[0-9]   root:video 660 =dri/
	
	      # alsa sound devices and audio stuff
	      pcm.*       root:audio 0660 =snd/
	      control.*   root:audio 0660 =snd/
	      midi.*      root:audio 0660 =snd/
	      seq         root:audio 0660 =snd/
	      timer       root:audio 0660 =snd/
	
	      adsp        root:audio 0660 >sound/
	      audio       root:audio 0660 >sound/
	      dsp         root:audio 0660 >sound/
	      mixer       root:audio 0660 >sound/
	      sequencer.* root:audio 0660 >sound/
	
	      event[0-9]+ root:input 660 =input/
	      mice        root:input 660 =input/
	      mouse[0-9]+ root:input 660 =input/
	
	      rfkill      root:${config.services.seatd.group} 660
	    ''
	  ];*/

	  
	   	# https://wiki.nftables.org/wiki-nftables/index.php/Quick_reference-nftables_in_10_minutes#Simple_IP/IPv6_Firewall
	   	services.nftables.configFile = pkgs.writeText "nftables.conf" ''
	   	      flush ruleset
	   	
	   	      table firewall {
	   	        chain incoming {
	   	          type filter hook input priority 0; policy drop;
	   	
	   	          # established/related connections
	   	          ct state established,related accept
	   	
	   	          # loopback interface
	   	          iifname lo accept
	   	
	   	          # icmp
	   	          icmp type echo-request accept
	   	
	   	          # open tcp ports: sshd (22)
	   	          tcp dport { 22 } accept
	   	        }
	   	      }
	   	
	   	      table ip6 firewall {
	   	        chain incoming {
	   	          type filter hook input priority 0; policy drop;
	   	
	   	          # established/related connections
	   	          ct state established,related accept
	   	
	   	          # invalid connections
	   	          ct state invalid drop
	   	
	   	          # loopback interface
	   	          iifname lo accept
	   	
	   	          # icmp
	   	          # routers may also want: mld-listener-query, nd-router-solicit
	   	          icmpv6 type { echo-request, nd-neighbor-solicit } accept
	   	
	   	          # open tcp ports: sshd (22)
	   	          tcp dport { 22 } accept
	   	        }
	   	      }
	   	    '';
}
