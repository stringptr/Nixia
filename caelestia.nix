{
  inputs,
  options,
  pkgs,
  ...
}:

{
  programs = {
    nix-ld = {
      libraries = with pkgs; [
        libqalculate
        libcava
        aubio
        ddcutil
        app2unit
        lm_sensors
        libqalculate
      ];
    };
  };

  services.upower.enable = true;

  environment = {
    systemPackages = with pkgs; [
      (inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules (
        with pkgs;
        [
          qt6.qtdeclarative
          qt6.qtmultimedia
          qt6.qtsvg
          qt6.qtbase
          qt6.qtwayland
          qt6.qt5compat
        ]
      ))

      libqalculate
      libcava
      aubio
      ddcutil
      app2unit
      lm_sensors
      libqalculate

      hicolor-icon-theme
      papirus-icon-theme

      kdePackages.breeze-icons
      kdePackages.breeze

      adwaita-icon-theme
      kdePackages.kiconthemes
    ];

    pathsToLink = [ "/share/icons" ];

    sessionVariables = {
      QML2_IMPORT_PATH = [
        "/home/ia/.config/quickshell/caelestia_experimental/build/qml"

        "${pkgs.papirus-icon-theme}/share"
        "/run/current-system/sw/share"
        "$HOME/.local/share"
      ];

      XCURSOR_THEME = "Papirus";
      QS_ICON_THEME = "Papirus";
    };
  };
}
