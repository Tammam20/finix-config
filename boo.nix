{ config, pkgs, inputs,  modules, lib, ... }:

{
# Use latest kernel.
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-x86_64-v3;
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
}
}
