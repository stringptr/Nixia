{
  inputs,
  pkgs,
  ...
}:

# let
#   mkOutOfStoreSymlink = config.lib.file.mkOutOfStoreSymlink;
# in
{
  home-manager.users.ia = {

    home.preferXdgDirectories = true;

    home.packages = with pkgs; [
      hicolor-icon-theme
      papirus-icon-theme

      kdePackages.breeze-icons
      kdePackages.breeze
    ];

    programs = {
      quickshell = {
        enable = true;
        package = (
          inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.withModules (
            with pkgs;
            [
              qt6.qtdeclarative
              qt6.qtmultimedia
              qt6.qtsvg
              qt6.qtbase
              qt6.qtwayland
              qt6.qt5compat

              qt6.qtpositioning
            ]
          )
        );
        activeConfig = "caelestia-experimental";
        systemd.enable = true;
      };
    };
    # programs = {
    #   yazi = {
    #     enable = true;
    #     initLua = "~/.config/yazi/init.lua";
    #   };
    # };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "26.05";
  };
}
