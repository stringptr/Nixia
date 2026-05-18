{
  pkgs,
  ...
}:

{
  imports = [
    home-manager/desktop.nix
  ];

  users.users.ia = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "power"
      "network"
    ];

    uid = 1000;
    home = "/home/ia";
    createHome = false;
    shell = pkgs.fish;

    subUidRanges = [
      {
        startUid = 100000;
        count = 65536;
      }
    ];

    subGidRanges = [
      {
        startGid = 100000;
        count = 65536;
      }
    ];

    group = "ia";
  };

  users.groups.ia = {
    gid = 1000;
  };
}
