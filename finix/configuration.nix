{ config, pkgs, modules, lib, ... }:

{


imports = with modules; [
    fstrim
    gnome-keyring
    gvfs
    micro
 #   niri
#    noisetorch
    pmount
    seahorse
    sway
    thermald
	fwupd
#	seatd
	upower
	brightnessctl
	seahorse
	zzz
	limine
	power-profiles-daemon
	bash	
	nano
	sudo
	dhcpcd
	iwd	
	nix-daemon
	polkit
	rtkit
	pipewire
	
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  finit.runlevel = 3;

  finit.services.nix-daemon = {
    environment.CURL_CA_BUNDLE = config.security.pki.caBundle;
  };

  services.nix-daemon = {
    enable = true;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  boot.loader.efi.canTouchEfiVariables = true;

  programs = {
    limine = {
      enable = true;
      settings.editor_enabled = true; # Disable on systems that need security
    };

    sudo.enable = true;
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
  };

  services = {
    polkit.enable = true;

    sysklogd.enable = true;

    dbus.enable = true;

   	mdevd.enable = true;
    #gardendevd.enable = true;

    dhcpcd.enable = true;
    rtkit.enable = true;
    thermald.enable = true;
    gvfs.enable = true;
    power-profiles-daemon.enable = true;
    power-profiles-daemon.extraGroups = lib.optionals config.services.seatd.enable [
    config.services.seatd.group
    ];
    fstrim.enable = true;
    fstrim.interval = "daily";
    upower.enable = true;
    fwupd.enable = true;

    iwd.enable = true;
    seatd.enable = true;
    /*greetd = {
    enable = true;
    settings = {
   default_session = {
   command = "${pkgs.tuigreet}/bin/tuigreet";
}; 
};
};*/
 };
	xdg.autostart.enable =  true;
    xdg.icons.enable = true;
    xdg.mime.enable = true;
  	xdg.portal.enable = true;
 	fonts = {
 	fontconfig.enable = true;
  	enableDefaultPackages = true;
  	packages = with pkgs; [
  	nerd-fonts.fira-code
	];
  };

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
      config.hardware.i2c.group
      #config.hardware.uinput.group
      "audio"
      # "gamemode"
     # "incus-admin"
      "input"
     # "keyd"
     # "kvm"
     # "vboxusers"
      "video"
      "wheel"
        ];
    password = "$6$1aOsu4xRRBDJWA3O$yUIEmHIzcJ2KczaW1RcVc6ji.vtCXND57iIqt8NfZHL7326zAViJrTGZriK.e1/5JovKqh/wElp7VmQB2TbLA."; #pass=vitrial
    packages = with pkgs; [];
  };
  
hardware.graphics.enable = true;
hardware.graphics.enable32Bit = true;
 # https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
  
hardware.console.keyMap = "de";
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
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
    brightnessctl
    playerctl
    papirus-icon-theme
    gnome-themes-extra
    lxqt.lxqt-policykit
    wl-clip-persist
    waybar
    wev
  ];

  # TODO: shouldn't this just be included by default?
    services.mdevd.hotplugRules = lib.mkMerge [
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
    ];
  providers.privileges.rules =
        lib.optionals config.services.seatd.enable [
          {
            command = "/run/current-system/sw/bin/poweroff";
            groups = [ config.services.seatd.group ];
            requirePassword = false;
          }
          {
            command = "/run/current-system/sw/bin/reboot";
            groups = [ config.services.seatd.group ];
            requirePassword = false;
          }
        ]
        ++ lib.optionals (config.services.seatd.enable && config.programs.zzz.enable) [
          {
            command = "/run/current-system/sw/bin/zzz";
            groups = [ config.services.seatd.group ];
            requirePassword = false;
          }
          {
            command = "/run/current-system/sw/bin/ZZZ";
            groups = [ config.services.seatd.group ];
            requirePassword = false;
          }
        ];
    };
}
