{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./cpu_gpu.nix
      ./asus.nix
      ./util.nix
      ./network.nix
      ./user.nix
      ./desktop.nix
      ./multimedia.nix
      ./dev.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.hostName = "Nixia";
  time.timeZone = "Asia/Jakarta";

  services.libinput.enable = true;

  environment.variables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_CACHE_HOME  = "$HOME/.cache";
    XDG_DATA_HOME   = "$HOME/.local/share";
    XDG_STATE_HOME  = "$HOME/.local/state";
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}

