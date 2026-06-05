{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    zoom-us
    kdePackages.kamoso
    gnome-network-displays
    qbittorrent
  ];
}
