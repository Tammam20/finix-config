{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    finix.url = "github:finix-community/finix?ref=main";
    community-modules.url = "github:finix-community/community-modules"; # "github:finix-community/community-modules";
   # sops-nix.url = "github:Mic92/sops-nix";
   # sops-nix.inputs.nixpkgs.follows = "nixpkgs";

   # noctalia.url = "github:noctalia-dev/noctalia";
   # noctalia.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      finix,
      community-modules,
 #     sops-nix,
 #     noctalia,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config.allowUnfree = true;
       /* overlays = [
          # self.overlays.xlibre
          self.overlays.custom
          sops-nix.overlays.default
        ];*/
      };
    in
    {
      /*overlays.xlibre = import ./xlibre.nix;
      overlays.custom = final: prev: {
        swayidle = prev.swayidle.override { systemdSupport = false; };
        xdg-desktop-portal = prev.xdg-desktop-portal.override { enableSystemd = false; };
        xwayland-satellite = prev.xwayland-satellite.override { withSystemd = false; };

        # noctalia v5!
        noctalia-shell = noctalia.packages.x86_64-linux.default;
      };*/

      # finix
      nixosConfigurations.t480 = finix.lib.finixSystem {
        inherit (pkgs) lib;

        specialArgs.modules = {
          inherit (community-modules.nixosModules)
           # cups
           # dinit
           # laptop
            # turnstile
            ;

          #noisetorch = toString nixpkgs + "/nixos/modules/programs/noisetorch.nix";
          #flirc = toString nixpkgs + "/nixos/modules/hardware/flirc.nix";
          #xfconf = ./xfconf.nix;
        };*/

        modules = [

          ./finix/configuration.nix
          ./finix/hardware-configuration.nix
          #./pam.nix
          #./sops
          # ./openbox.nix
          # ./plasma.nix
          # ./xfce.nix
          # ./podman.nix

          { nixpkgs.pkgs = pkgs; }
        ];
      };
    };
}
