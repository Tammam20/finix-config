{ config, pkgs, inputs, localPackages,  modules, lib, ... }:

{
	environment.systemPackages = [
	      localPackages.python-validity
	      pkgs.fprintd
	      pkgs.gcc
	      pkgs.xdg-utils
	      pkgs.adwaita-qt
	      pkgs.adwaita-qt6
	      pkgs.qgnomeplatform
	      pkgs.qgnomeplatform-qt6
  		  #pkgs.bluez
		  #pkgs.blueman
	      pkgs.vim
	      pkgs.wget
	      pkgs.nano
	      pkgs.git
	      pkgs.nixos-rebuild-ng
	      pkgs.iputils
	      pkgs.iproute2
	      pkgs.brave
	      pkgs.chezmoi
	      pkgs.gh
	      pkgs.keepassxc
	      pkgs.foot
	      pkgs.cliphist
	      pkgs.wmenu
	      pkgs.wl-clipboard
	      pkgs.wf-recorder
	      pkgs.grim
	      pkgs.slurp
	      pkgs.swaybg
	      pkgs.sway-audio-idle-inhibit
	      pkgs.swayidle
	      pkgs.swaynotificationcenter
	      pkgs.playerctl
	      pkgs.papirus-icon-theme
	      pkgs.gnome-themes-extra
	      pkgs.lxqt.lxqt-policykit
	      pkgs.wl-clip-persist
	      pkgs.waybar
	      pkgs.wev
	      pkgs.pavucontrol
	      pkgs.thunar
	      pkgs.dconf
	      pkgs.xfconf
	      pkgs.btop
	      #pkgs.atop
		  pkgs.fastfetch
	      pkgs.lm_sensors
	      pkgs.dconf-editor
	      /*pkgs.virt-manager
		  pkgs.qemu
	      pkgs.virt-viewer
	      pkgs.spice-gtk
	      pkgs.virtiofsd*/
		  pkgs.file-roller
  		  pkgs.shellcheck
  		  pkgs.powertop
  		  pkgs.s-tui
	  	  pkgs.multimarkdown
	  	  pkgs.qbittorrent
	  	  pkgs.nixfmt
	  	  pkgs.nil
	  	  pkgs.emacs
	  	  pkgs.tldr
	  	  pkgs.pciutils
	 	  pkgs.usbutils
	 	  pkgs.coreutils
	  	  pkgs.clang
	  	  pkgs.ripgrep
	 	  pkgs.fd
	  	  pkgs.lshw
	  	  pkgs.ollama
	  	  pkgs.bash-completion
	  	  pkgs.man
	  	  pkgs.matugen
  		  #pkgs.blesh
   		  #pkgs.inputs.noctalia.packages.${pkgs.stdenv.system}.default
   		  inputs.serpantinum.packages.${pkgs.stdenv.system}.default
   		  #pkgs.noctalia
	    ];


	  security.pam.environment = {
      # https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
      LIBVA_DRIVER_NAME.default = "iHD";
      # sets NIX_PATH env variable for ad hoc nix shells
      NIX_PATH.default = "nixpkgs=${pkgs.path}";
      
      QT_QPA_PLATFORMTHEME.default = "gnome";
      QT_STYLE_OVERRIDE.default = "adwaita-dark";
    };

	# shell fix # ln -sf ${pkgs.blesh}/share/blesh $out/share/blesh
	environment.extraSetup =''
			ln -sf ${pkgs.bash-completion}/share/bash-completion $out/share/bash-completion
		  '';

	environment.pathsToLink = [ "/share/man" ];
	environment.variables.MANPATH = "/run/current-system/sw/share/man";
}
