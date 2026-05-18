{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./cpu_gpu.nix
    ./asus.nix
    ./util.nix
    ./network.nix
    ./user.nix
    ./desktop.nix
    ./application.nix
    ./multimedia.nix
    ./dev.nix
  ];

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

  };

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "Nixia";
  time.timeZone = "Asia/Jakarta";

  services.libinput.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?
}
