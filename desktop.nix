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
    noctalia-shell
    phinger-cursors
    fastfetch

    imv
    mpv
    thunar

    papirus-icon-theme
    pcre
  ];

  services.upower.enable = true;

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
      config.common.default = "*";
    };
    icons.enable = true;
  };

  services = {
    pipewire = {
      audio.enable = true;
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    material-symbols
    material-icons
    inter
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";
  };
  gtk.iconCache.enable = true;
}
