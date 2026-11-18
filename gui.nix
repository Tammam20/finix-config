{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  services = {
    # dbus

    dbus.enable = true;
    dbus.packages = [
      pkgs.dconf
      pkgs.xfconf
      pkgs.thunar
      pkgs.at-spi2-core
      #pkgs.tumbler
    ];

    # seatd and it's complements

    seatd.enable = true;

    upower.enable = true;

    polkit.enable = true;

    udev.enable = true;

    gvfs.enable = true;

    rtkit.enable = true;
    rtkit.extraGroups = [
      config.services.seatd.group
    ];

    /*
      mdevd.enable = true;
      # required for graphical environments
      mdevd.nlgroups = 4;
      #gardendevd.enable = true;
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
            	      ntsync 0:0 666
            	    ''
        ];
    */
  };
}
