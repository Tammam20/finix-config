{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  networking.hostName = "t480"; # Define your hostname.

  # Set your time zone.
  time.timeZone = "Asia/Baghdad";

  # Define a user account. Don't forget to set a password with ‘passwd’.

  # graphics
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  # https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
  hardware.graphics.extraPackages = [ pkgs.intel-media-driver ];
  hardware.graphics.extraPackages32 = [ pkgs.pkgsi686Linux.intel-media-driver ];
  hardware.console.keyMap = "de";

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        #serif      = [ "Noto Serif" ];
        #sansSerif  = [ "Noto Sans" ];
        monospace = [ "JetBrainsMono Nerd Font Mono" ];
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
}
