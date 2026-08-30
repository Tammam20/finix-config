{ config, pkgs, inputs,  modules, lib, ... }:

{


imports = with modules; [
    fstrim
    bluetooth
    gnome-keyring
    gvfs
    micro
	getty
    pmount
    seahorse
    sway
    thermald
	#fwupd
	upower
	brightnessctl
	seahorse
	zzz
	limine
	tlp
	#power-profiles-daemon
	bash	
	nano
	sudo
	dhcpcd
	chronyd
	earlyoom
	iwd	
	nix-daemon
	polkit
	rtkit
	pipewire
	limine
	nftables
	wireplumber
	sysklogd
	fprintd
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;

  # graphical runlevel
  finit.runlevel = 3;

   finit.cgroups.system.settings = {
     "cpu.weight" = 100;
    };


  finit.services.nix-daemon = {
    environment.CURL_CA_BUNDLE = config.security.pki.caBundle;
  };
    

  services.nix-daemon = {
    enable = true;
    package = inputs.nix.packages.${pkgs.stdenv.system}.default;
    settings = {
      auto-optimise-store = true;
      eval-cores = 0;
      lazy-trees = true;
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

  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
   limine = {
    enable = true;
	settings = { 
	editor_enabled = true; # Disable on systems that need security
    interface_resolution = "1920x1080";
    wallpaper = [ ./limine-wallpaper.png ];
    wallpaper_style = "stretched";
    backdrop = "16181d";
    term_background = "c0161818";
    term_foreground = "dcdee4";
    term_background_bright = "d31f30";
    term_foreground_bright = "ffffff";
    term_palette = "16181d;d31f30;7d7d7d;de3040;3a3f4b;e84050;9aa0ac;dcdee4";
    term_palette_bright = "2a2d35;e84050;9aa0ac;e84050;5a6070;f06070;c0c4cc;ffffff";
    term_margin = 24;
    term_margin_gradient = 24;
    interface_branding = "finix";
    interface_branding_colour = "e84050";
    interface_help_colour = "7d7d7d";
    interface_help_colour_bright = "dcdee4";
    interface_help_hidden = false;
   	 };
   };

    sudo.enable = true;
    fastfetch.enable = true;
	micro.enable = true;
	micro.defaultEditor = true;
	nano.enable = true;
	nano.defaultEditor = false;
    bash.enable = true;
    sway.enable = true;
    pmount.enable = true;
    seahorse.enable = true;
    gnome-keyring.enable = true;
    brightnessctl.enable = true;
    zzz.enable = true;
    resolvconf.enable = true;
    
    # audio
    pipewire.enable = true;
    pipewire.jack.enable = true;
    pipewire.alsa.enable = true;
    pipewire.alsa.support32Bit = true;
   	wireplumber.enable = true;
  };

# additional audio
users.groups.audio.gid = config.ids.gids.audio;

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
    upower.enable = true;
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
	xdg.autostart.enable = true;
    xdg.icons.enable = true;
    xdg.mime.enable = true;
  	xdg.portal.enable = true;
  	xdg.terminal-exec.enable = true;
  	xdg.terminal-exec.settings = {
  		default = [
  			"foot.desktop"
  		];
  	};
  	xdg.portal.portals = [
  	    pkgs.xdg-desktop-portal-gtk
  	    pkgs.xdg-desktop-portal-wlr
  	  ];
 	
  networking.hostName = "t480"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Baghdad";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tammam = {
    isNormalUser = true;
    description = "Tammam Faris";
    extraGroups = [ 
     "wheel" 
     "video" 
      config.services.seatd.group 
      "audio"
      "input"
        ];
    password = "$y$j9T$xGi7MwQ4ibnT7yMU0l4Xq/$aw2ymKFjLE/SQJ.LNmtFInUYdPRAzMa7wwkCLpCKOA7"; #pass=hh
    packages = with pkgs; [];
  };

   # graphics
	hardware.graphics.enable = true;
	hardware.graphics.enable32Bit = true;
 	# https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
  	hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
  	hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
  	hardware.console.keyMap = "de";
  
  	security.pam.environment = {
      # https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
      LIBVA_DRIVER_NAME.default = "iHD";
      # sets NIX_PATH env variable for ad hoc nix shells
      NIX_PATH.default = "nixpkgs=${pkgs.path}";
      
      QT_QPA_PLATFORMTHEME.default = "gnome";
      QT_STYLE_OVERRIDE.default = "adwaita-dark";
    };

	# qt theme
	/*environment.variables = {
		QT_QPA_PLATFORMTHEME = "gnome";
		QT_STYLE_OVERRIDE = "adwaita-dark";
	};*/
	

  fonts = {
   	fontconfig = { 
   	enable = true; 
	defaultFonts = {
	        #serif      = [ "Noto Serif" ];
	        #sansSerif  = [ "Noto Sans" ];
	        monospace  = [ "JetBrainsMono Nerd Font Mono" ];
	        #emoji      = [ "Noto Color Emoji" ];
	      };
   	};
   	
    	enableDefaultPackages = true;
    	packages = with pkgs; [
    	nerd-fonts.jetbrains-mono
    	nerd-fonts.symbols-only
    	symbola
  	];
    };


    # libvirt
   /* finit.services.libvirtd = {
          description = "libvirt virtualisation daemon";
          runlevels   = "2345";
          conditions  = [ "service/syslogd/ready" ];
          command     = "${pkgs.libvirt}/bin/libvirtd";
        };*/
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    gcc
    xdg-utils
    adwaita-qt
    adwaita-qt6
    qgnomeplatform
    qgnomeplatform-qt6
  	#bluez
  	#blueman
    vim
    wget
    nano
    git
    nixos-rebuild-ng
    iputils
    iproute2
    brave
    chezmoi
    gh
    keepassxc
    foot
    cliphist
    wmenu
    wl-clipboard
    wf-recorder
    grim
    slurp
    swaybg
    sway-audio-idle-inhibit
    swayidle
    swaynotificationcenter
    playerctl
    papirus-icon-theme
    gnome-themes-extra
    lxqt.lxqt-policykit
    wl-clip-persist
    waybar
    wev
    pavucontrol
    thunar
    dconf
    xfconf
    btop
    #atop
	#fastfetch
    lm_sensors
    dconf-editor
    /*virt-manager
	qemu
    virt-viewer
    spice-gtk
	virtiofsd*/
	file-roller
  	shellcheck
  	powertop
  	s-tui
  	multimarkdown
  	qbittorrent
  	nixfmt
  	nil
  	emacs
  	tldr
  	pciutils
 	usbutils
 	coreutils
  	clang
  	ripgrep
 	fd
  	lshw
  	inputs.caelestia-shell.packages.${pkgs.stdenv.system}.with-cli
  	#noctalia-shell
  ];

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
  providers.privileges.rules = [
          {
            command = "/run/current-system/sw/bin/poweroff";
            groups = [ config.services.seatd.group ];
            runAs = "root";
            requirePassword = false;
          }
          {
            command = "/run/current-system/sw/bin/reboot";
            groups = [ config.services.seatd.group ];
            runAs = "root";
            requirePassword = false;
          }
          {
            command = "/run/current-system/sw/bin/zzz";
            groups = [ config.services.seatd.group ];
            runAs = "root";
            requirePassword = false;
          }
          {
            command = "/run/current-system/sw/bin/ZZZ";
            groups = [ config.services.seatd.group ];
            runAs = "root";
            requirePassword = false;
          }
        ];
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
