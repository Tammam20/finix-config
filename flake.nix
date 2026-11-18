{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    finix.url = "github:finix-community/finix?ref=main";
    community-modules.url = "github:finix-community/community-modules";
    #nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      finix,
      community-modules,
      # nix-cachyos-kernel,
      nix,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config.allowUnfree = true;
        overlays = [
          #    nix-cachyos-kernel.overlays.pinned
        ];
      };
      #localPackages = import ./pkgs/default.nix { pkgs = pkgs; };
    in
    {

      # finix
      nixosConfigurations.t480 = finix.lib.finixSystem {
        inherit (pkgs) lib;

        specialArgs = {
          #   inherit localPackages;
          inherit inputs;
        };

        modules = [
          ./boot.nix
          ./gui.nix
          ./imports.nix
          ./miscPkgs.nix
          ./net.nix
          ./nix.nix
          ./pw.nix
          ./shell.nix
          ./t480.nix
          ./users.nix
          #./validity.nix
          ./virtualisation.nix
          ./zzz.nix
          community-modules.nixosModules.fastfetch
          { nixpkgs.pkgs = pkgs; }
        ];
      };
      /*
        packages.x86_64-linux.local = pkgs.buildEnv {
              name = "local";

              paths = [

              ];
            };
      */
    };
}
