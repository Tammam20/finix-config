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

    #bluetooth.enable = true;
    #bluetooth.settings.Policy.AutoEnable = false;

    providers.firewall.allowedTCPPorts = [ 22 ];

  };
}
