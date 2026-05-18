{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
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
    # dconf.enable = true;
    # yazi.enable = true;
  };

  environment.systemPackages = with pkgs; [
    awww
    kitty
    foot
    clipse
    inputs.zen-browser.packages.${stdenv.hostPlatform.system}.default
    starship
    fastfetch
    thunar
    pcre2
    yazi

    kdePackages.breeze-icons
    kdePackages.breeze

    kdePackages.syntax-highlighting
  ];

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    inter
  ];

  programs = {
    nix-ld = {
      libraries = with pkgs; [
        pcre2
        kdePackages.syntax-highlighting
      ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
    mime.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  gtk = {
    iconCache.enable = true;
  };
}
