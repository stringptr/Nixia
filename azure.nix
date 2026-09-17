{
  inputs,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    azure-cli
  ];

  # services.gnome.gnome-keyring.enable = true;
  # security.polkit.enable = true;

  # programs = {
  #   nix-ld = {
  #     enable = true;
  #     libraries = with pkgs; [
  #       nspr
  #       nss
  #       atk
  #       cups
  #       dbus
  #       cairo
  #       gtk3
  #       pango
  #       libxcomposite
  #       libxdamage
  #       libxfixes
  #       libxrandr
  #       libxkbcommon
  #       libgbm
  #       expat
  #       alsa-lib
  #
  #       gnome-keyring
  #       polkit_gnome
  #       libsecret
  #
  #       # dotnetCorePackages.runtime_10_0-bin
  #       # dotnetCorePackages.runtime_11_0-bin
  #       # dotnetCorePackages.dotnet_10.runtime
  #       # dotnetCorePackages.dotnet_11.runtime
  #       # dotnet-runtime_10
  #       # dotnet-runtime_11
  #       # dotnet-sdk_10
  #       # dotnet-sdk_11
  #       # dotnet-aspnetcore_10
  #       # dotnet-aspnetcore_11
  #     ];
  #   };
  # };
}
