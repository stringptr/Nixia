{ options, inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inputs.nix-alien.packages.${system}.nix-alien
    e2fsprogs
    git
    delta
    brightnessctl
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
      libraries = options.programs.nix-ld.libraries.default ++ (
        with pkgs; [
          glib
          javaPackages.compiler.openjdk17
          ripdrag
        ]
      );
    };
  };

  services.envfs.enable = true;
}
