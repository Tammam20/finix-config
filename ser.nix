
  services = {
    polkit.enable = true;

    sysklogd.enable = true;

    chrony.enable = true;
    fcron.enable = true;
    getty.enable = true;
   

    earlyoom.enable = true;
    earlyoom.extraArgs = [
      "-r"
      "3600"
    ];

    #bluetooth.enable = true;
    #bluetooth.settings.Policy.AutoEnable = false;

    nftables.enable = true;

    iwd.enable = true;

  };

  services.nix-daemon = {
    enable = true;
    package = inputs.nix.packages.${pkgs.stdenv.system}.default;
    settings = {
      auto-optimise-store = true;
      eval-cores = 0;
      lazy-trees = true;
      flake-registry = "https://channels.nixos.org/flake-registry.json";
      experimental-features = [
        "parallel-eval"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        "https://finix.cachix.org"
        "https://install.determinate.systems"
      ];
      trusted-public-keys = [
        "finix.cachix.org-1:0ejikHDeCp0UErsduUUHcg9IJczY2/h2e5132Z/As/c="
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      ];
    };
  };

  providers.firewall.allowedTCPPorts = [ 22 ];
}
