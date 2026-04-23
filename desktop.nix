{ inputs, pkgs, ... }:

{
  imports =
    [
      # ./noctalia.nix
      ./caelestia.nix
    ];

  # nixpkgs.overlays = [ inputs.yazi.overlays.default ];
  # nix.settings.extra-substituters = [ "https://yazi.cachix.org" ];
  # nix.settings.extra-trusted-public-keys = [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];

  programs = {
    niri = {
      enable = true;
      useNautilus = false;
    };
    # yazi.enable = true;
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
    phinger-cursors
    pcre
    yazi
  ];

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    inter
  ];

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
    icons.enable = true;
    mime.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "adwaita-dark";
  };

  gtk.iconCache.enable = true;
}
