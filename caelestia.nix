{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    quickshell
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    kdePackages.qtsvg
    kdePackages.qtwayland
    kdePackages.qt5compat
    libqalculate
    libcava
    aubio

    hicolor-icon-theme
    papirus-icon-theme
  ];

  services.upower.enable = true;

  programs = {
    nix-ld = {
      libraries = with pkgs; [
        kdePackages.qtbase
        kdePackages.qtdeclarative
        kdePackages.qtmultimedia
        kdePackages.qtsvg
        kdePackages.qtwayland
        kdePackages.qt5compat
        libqalculate
        libcava
        aubio
      ];
    };
  };

  environment.sessionVariables = {
    QML2_IMPORT_PATH = [
      "/home/ia/.config/quickshell/caelestia_experimental/build/qml"
      "/home/ia/.config/quickshell/caelestia_experimental/build/qml/"
      "/home/ia/.config/quickshell/caelestia_experimental/build/"
      "/home/ia/.config/quickshell/caelestia_experimental/build"
      "${pkgs.quickshell}/lib/qt-6/qml"

      "${pkgs.papirus-icon-theme}/share"
      "${pkgs.hicolor-icon-theme}/share"
      "/run/current-system/sw/share"
      "$HOME/.local/share"
    ];
  };
}
