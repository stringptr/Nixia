{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.spicetify-nix.nixosModules.spicetify
  ];

  environment.systemPackages = with pkgs; [
    imv
    mpv
    qpwgraph
    easyeffects
    lsp-plugins
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-pipewire-audio-capture
      ];
    })
    ffmpeg-full
    libmysofa
    libnotify
  ];

  services = {
    pipewire = {
      audio.enable = true;
      enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      jack.enable = true;
    };
  };

  programs = {
    nix-ld = {
      libraries = with pkgs; [
        libmysofa
      ];
    };
    gpu-screen-recorder = {
      enable = true;
      ui.enable = true;
    };
  };

  programs.spicetify =
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      enable = true;
      wayland = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblockify
      ];
    };
}
