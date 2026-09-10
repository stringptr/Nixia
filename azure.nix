{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    azure-cli
  ];

  services.gnome.gnome-keyring.enable = true;
  security.polkit.enable = true;

  programs = {
    nix-ld = {
      libraries = with pkgs; [
        nspr
        nss
        atk
        cups
        dbus
        cairo
        gtk3
        pango
        libxcomposite
        libxdamage
        libxfixes
        libxrandr
        libxkbcommon
        libgbm
        expat
        alsa-lib

        gnome-keyring
        polkit_gnome
        libsecret
      ];
    };
  };
}
