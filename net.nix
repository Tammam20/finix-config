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
    dhcpcd.enable = true;

    avahi.enable = true;

    nftables.enable = true;

    iwd.enable = true;

    # Set your time zone.
    time.timeZone = "Asia/Baghdad";

    #bluetooth.enable = true;
    #bluetooth.settings.Policy.AutoEnable = false;

    providers.firewall.allowedTCPPorts = [ 22 ];

  };
}
