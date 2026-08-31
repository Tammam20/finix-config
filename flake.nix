{
  inputs = {
    nixpkgs.follows = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    finix.url = "github:finix-community/finix?ref=main";
    community-modules.url = "github:finix-community/community-modules";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      finix,
      community-modules,
      nix-cachyos-kernel,
      nix,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config.allowUnfree = true;
        overlays = [
                  nix-cachyos-kernel.overlays.pinned
                ];
      };
      localPackages = import ./pkgs/default.nix { pkgs = pkgs; };
    in
    {

      # finix
      nixosConfigurations.t480 = finix.lib.finixSystem {
        inherit (pkgs) lib;

        specialArgs = {
         inherit localPackages;
         inherit inputs;
        };

        modules = [
          ./hardware-configuration.nix
          ./validity.nix
          ./boo.nix
		  ./env.nix
		  ./ext.nix
          ./fin.nix
          ./imp.nix
          ./pro.nix
          ./ser.nix
          ./use.nix
          ./xdg.nix
          community-modules.nixosModules.fastfetch
          { nixpkgs.pkgs = pkgs; }
        ];
      };
      /*packages.x86_64-linux.local = pkgs.buildEnv {
              name = "local";
      
              paths = [
              
              ];
            };*/
    };
}
