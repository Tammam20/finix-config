{
  config,
  pkgs,
  inputs,
  modules,
  lib,
  ...
}:

{
  users.users.tammam = {
    isNormalUser = true;
    description = "Tammam Faris";
    extraGroups = [
      "wheel"
      "video"
      config.services.seatd.group
      "audio"
      "input"
    ];
    password = "$y$j9T$xGi7MwQ4ibnT7yMU0l4Xq/$aw2ymKFjLE/SQJ.LNmtFInUYdPRAzMa7wwkCLpCKOA7"; # pass=hh
    packages = with pkgs; [ ];
  };

  # additional audio
  users.groups.audio.gid = config.ids.gids.audio;

}
