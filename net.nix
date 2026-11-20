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

  };

  # Set your time zone.
  time.timeZone = "Asia/Baghdad";

  # firewall configuration
  providers.firewall.allowedTCPPorts = [
    # 22
  ];
  providers.firewall.allowedUDPPorts = [
    5353
    1900
  ];

  providers.firewall.allowedTCPPortRanges = [
    {
      from = 8008;
      to = 8009;
    }
  ];

  providers.firewall.allowedUDPPortRanges = [
    {
      from = 32768;
      to = 65535;
    }
  ];
}
