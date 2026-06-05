{
  options,
  inputs,
  pkgs,
  ...
}:

{
  nixpkgs.overlays = [
    (self: super: {
      btop = super.btop.override { cudaSupport = true; };
    })
  ];

  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages.${stdenv.hostPlatform.system}.nix-alien
    comma
    e2fsprogs
    efibootmgr
    reptyr
    delta
    gnused
    brightnessctl
    egl-wayland
    libxcb
    bat
    bat-extras.batman
    fzf
    ripdrag
    fd
    ripgrep
    zoxide
    tree-sitter
    tealdeer
    lsd
    duf
    gdu
    wl-clipboard
    chafa
    pulsemixer
    v4l-utils
    libv4l
    btop
    television
    ttfautohint
    wget
    trash-cli
  ];

  programs = {
    fish.enable = true;
    # command-not-found.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "keep-since 1d --keep 2";
    };
    nix-ld = {
      enable = true;
      libraries =
        options.programs.nix-ld.libraries.default
        ++ (with pkgs; [
          gnused
          ripdrag
        ]);
    };
  };

  services.envfs.enable = true;
}
