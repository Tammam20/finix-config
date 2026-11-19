{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  # install acpid and zzz
  services.acpid.enable = true;
  programs.zzz.enable = true;

  # configuration for acpid
  services.acpid.handlers = {
    sleepOnLidClose.enable = true;
    sleepOnLidClose.action = "sudo zzz";
    sleepOnLidClose.event = "button/lid.*";
  };

  services.acpid.handlers = {
    sleepOnPowerpress.enable = true;
    sleepOnPowerpress.action = "sudo poweroff";
    sleepOnPowerpress.event = "button/power.*";
  };

  # no password for poweroff/reboot/zzz/ZZZ
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
}
