{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  #acpid
  services.acpid.enable = true;

  #zzz
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
