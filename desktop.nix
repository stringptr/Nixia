{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    ./caelestia.nix
  ];

  nix.settings = {
    extra-substituters = [
      "https://stringptr.cachix.org-1?priority=91"
    ];
    extra-trusted-public-keys = [
      "stringptr.cachix.org-1:QqkadKBexul9n15fldZGqAoxos14/5PfHVoL6O91EKk="
    ];
  };

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

    # xdg-desktop-portal-termfilechooser

    wallust
    matugen

    glib
    inputs.strata.packages.${pkgs.stdenv.hostPlatform.system}.strata
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

        wallust
        matugen
      ];
    };
    xwayland.enable = true;

    # serpantinum.enable = false;
  };

  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}"
  ];

  # environment.variables = {
  #   GTK_USE_PORTAL = "1"; # legacy
  #   GDK_DEBUG = "portals"; # termfilechooser
  #   # QT_QPA_PLATFORMTHEME = "xdgdesktopportal";
  #   TDESKTOP_USE_GTK_FILE_DIALOG = 1; # telegram
  # };

  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gnome
        # xdg-desktop-portal-termfilechooser
      ];
      config.common = {
        default = "*";
        # "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ]; # IMPORTANT!
        # "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        # "org.freedesktop.impl.portal.Screenshot" = "gnome";
      };
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
