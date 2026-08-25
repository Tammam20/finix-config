{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    finix.url = "github:finix-community/finix?ref=main";
    community-modules.url = "github:finix-community/community-modules";
  };

  outputs =
    {
      self,
      nixpkgs,
      finix,
      community-modules,
    }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";

        config.allowUnfree = true;
      };
      localPackages = import ./pkgs/default.nix { pkgs = pkgs; };
    in
    {

      # finix
      nixosConfigurations.t480 = finix.lib.finixSystem {
        inherit (pkgs) lib;

        specialArgs = {
         inherit localPackages;
        };

        modules = [
          ./configuration.nix
          ./hardware-configuration.nix
          ./validity.nix
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
