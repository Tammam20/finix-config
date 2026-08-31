{ config, pkgs, inputs,  modules, lib, ... }:

{
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
}
