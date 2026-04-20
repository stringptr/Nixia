{ inputs, pkgs, ... }:

{
  programs = {
    niri = {
      enable = true;
      useNautilus = false;
    };
    yazi.enable = true;
  };

  environment.systemPackages = with pkgs; [
    awww
    kitty
    foot
    clipse
    inputs.zen-browser.packages.${system}.default
    starship
    fastfetch
    thunar
  ];

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    inter
  ];
}
