{
  config,
  pkgs,
  inputs,
  localPackages,
  modules,
  lib,
  ...
}:

{

  security.pam.environment = {
    # https://wiki.nixos.org/wiki/Accelerated_Video_Playback#Intel
    LIBVA_DRIVER_NAME.default = "iHD";
    # sets NIX_PATH env variable for ad hoc nix shells
    NIX_PATH.default = "nixpkgs=${pkgs.path}";

    QT_QPA_PLATFORMTHEME.default = "gnome";
    QT_STYLE_OVERRIDE.default = "adwaita-dark";
  };

  environment.etc.set-environment.text = ''
    export PATH="/run/current-system/sw/bin:/nix/var/nix/profiles/default/bin:$PATH"
    export NIX_PATH="nixpkgs=${pkgs.path}"
  '';

  # shell fix  ln -sf ${pkgs.blesh}/share/blesh $out/share/blesh
  environment.extraSetup = ''
        			ln -sf ${pkgs.bash-completion}/share/bash-completion $out/share/bash-completion
    				
        		  '';

  environment.pathsToLink = [ "/share/man" ];
  environment.variables.MANPATH = "/run/current-system/sw/share/man";
}
