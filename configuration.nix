# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./boot.nix
      ./asus-nvidia.nix
      ./util.nix
      ./network.nix
      ./desktop.nix
      ./dev.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;


  networking.hostName = "Nixia";
  time.timeZone = "Asia/Jakarta";

  networking.networkmanager.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  users.users.ia = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "power" "network" ];
    uid = 1000;
    home = "/home/ia";
    createHome = false;
    shell = pkgs.fish;
    subUidRanges = [{ startUid = 100000; count = 65536; }];
    subGidRanges = [{ startGid = 100000; count = 65536; }];
    group = "ia";
  };

  users.groups.ia = {
    gid = 1000;
  };

  system.stateVersion = "25.11"; # Did you read the comment?
}

