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
    starship
    fastfetch
    thunar
    # phinger-cursors
    bibata-cursors
    pcre2
    yazi

    # adwaita-qt6
    kdePackages.breeze-icons
    kdePackages.breeze

    kdePackages.syntax-highlighting
    xwayland-satellite
  ];

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    # nerd-fonts.maple-mono
    material-symbols
    material-icons
    inter
    noto-fonts
    inputs.iasevka.packages.${pkgs.stdenv.hostPlatform.system}.iasevka
  ];

  programs = {
    nix-ld = {
      libraries = with pkgs; [
        pcre2
        kdePackages.syntax-highlighting
      ];
    };
    xwayland.enable = true;
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
    mime.enable = true;
    mime.defaultApplications = {
      "application/pdf" = "zen.desktop";
    };
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
