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

    thermald.enable = true;

    tlp.enable = true;
    tlp.settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      #MEM_SLEEP_ON_AC = "deep";
      #MEM_SLEEP_ON_BAT = "deep";
      CPU_DRIVER_OPMODE_ON_AC = "active";
      CPU_DRIVER_OPMODE_ON_BAT = "active";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
      #PCIE_ASPM_ON_AC = "powersave";
      #PCIE_ASPM_ON_BAT = "powersave";
      #WIFI_PWR_ON_AC = "off";
      #WIFI_PWR_ON_BAT = "off";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 30;

      INTEL_GPU_MIN_FREQ_ON_AC = 350;
      INTEL_GPU_MIN_FREQ_ON_BAT = 350;
      INTEL_GPU_MAX_FREQ_ON_AC = 1050;
      INTEL_GPU_MAX_FREQ_ON_BAT = 350;
      INTEL_GPU_BOOST_FREQ_ON_AC = 1100;
      INTEL_GPU_BOOST_FREQ_ON_BAT = 350;
      SOUND_POWER_SAVE_ON_AC = 1;
      SOUND_POWER_SAVE_ON_BAT = 1;
      START_CHARGE_THRESH_BAT1 = 75;
      STOP_CHARGE_THRESH_BAT1 = 80;
      NMI_WATCHDOG = 0;
      #START_CHARGE_THRESH_BAT0 = 75;
      #STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  /*
    	      power-profiles-daemon.enable = true;
    	      power-profiles-daemon.extraGroups =  [
    	      config.services.seatd.group
    	      ];
  */

}
